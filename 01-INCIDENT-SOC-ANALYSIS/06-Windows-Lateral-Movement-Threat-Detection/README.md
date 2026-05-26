# Windows Lateral Movement & Threat Detection Lab
## Splunk + Sysmon + Kali Linux SOC Detection Project

---

# 📌 Project Overview

**This project simulates a realistic Windows lateral movement intrusion scenario using:**

- Kali Linux as the attacker machine
- Windows 10 as the victim workstation
- Splunk Enterprise as the SIEM
- Sysmon for advanced endpoint telemetry
- Splunk Universal Forwarder for centralized log ingestion

**The goal of the lab was to:**

- Simulate attacker behavior
- Generate realistic Windows telemetry
- Detect malicious activity in Splunk
- Perform threat hunting using Sysmon and Windows Event Logs
- Build practical SOC analyst and detection engineering skills

**This project mirrors techniques commonly used during:**

- Ransomware intrusions
- Internal network compromise
- SMB lateral movement
- Administrative abuse
- PowerShell-based attacks

---

# Lab Architecture

## Environment

| Machine | Role |
|---|---|
| Kali Linux VM | Attacker |
| Windows 10 Workstation | Victim |
| Splunk Enterprise | SIEM |
| Sysmon | Endpoint telemetry |
| Splunk Universal Forwarder | Log forwarding |

---

# Network Layout

```text
Kali Linux VM
192.168.178.73
        |
        |
        v
Windows 10 Workstation
192.168.178.37
        |
        |
        v
Splunk Enterprise SIEM
```

---

# Tools Used

## Offensive Tools

| Tool | Purpose |
|---|---|
| CrackMapExec | SMB authentication & remote execution |
| Hydra | Brute force testing |
| Nmap | Service enumeration |
| FreeRDP | RDP ports testing |

---

## Defensive Tools

| Tool | Purpose |
|---|---|
| Sysmon | Advanced Windows telemetry |
| Splunk Enterprise | SIEM platform |
| Splunk Universal Forwarder | Log forwarding |

---

# Windows Logging Configuration

## Security Event Logging

Enabled logging for:

| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4648 | Explicit credential logon |
| 4672 | Special privileges assigned |

---

## Sysmon Logging

Enabled:

| Event ID | Description |
|---|---|
| 1 | Process creation |
| 3 | Network connection |
| 10 | Process access |

---

## PowerShell Logging

Enabled:

| Event ID | Description |
|---|---|
| 4104 | Script Block Logging |


# Victim User Creation

Created 3 new users to act as victims.

![user-creation](screenshots/user-creation.png)

---

# SplunkForwarder Verification

Verified SplunkForwarder running locally after installation and configuration using:

```ruby
Get-Service SplunkForwarder
```

![splunkf-verification](screenshots/splunkf-verification.png)

---

# Sysmon Verification

Verified Sysmon logging locally using:

```ruby
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 5
```

![winevent-create](screenshots/winevent-create.png)

Successfully confirmed:

- Process Create events
- Network Connection events
- Parent-child process telemetry

---

# Splunk Add-ons Installed

Installed:

- Splunk Add-on for Microsoft Sysmon
- Splunk Add-on for Microsoft Windows

Benefits:

- Proper field extraction
- CIM normalization
- Better searches
- Security dashboards

---

# Attack Simulation

# 1. SMB Authentication Attack

Simulated attacker authentication attempts against the Windows workstation.

## Command

```ruby
crackmapexec smb 192.168.x.x -u users.txt -p passwords.txt
```

![img2-smb-attack](screenshots/img2-smb-attack.png)

## Successful Authentication

```bash
crackmapexec smb 192.168.x.x -u helpdesk -p 'Password123!'
```

![img3-success](screenshots/img3-success.png)
---

# Telemetry Generated

Generated:

- Event ID 4624
- Event ID 4625
- NTLM authentication activity
- Source IP visibility
- SMB logon events

---

# Sample Detection


```ruby
index=* EventCode=4625
| stats count by Source_Network_Address Account_Name
```

![img3-failed-login](screenshots/img3-failed-login.png)

---

# 2. Remote Command Execution

Simulated remote command execution over SMB.

## Command

```ruby
crackmapexec smb 192.168.178.37 -u helpdesk -p 'Password123!' -x "whoami"
```

![img5-whoami](screenshots/img5-whoami.png)

---

# Telemetry Generated

Generated:

- Sysmon Event ID 1
- cmd.exe execution
- services.exe parent-child chain
- Remote process execution artifacts

---

# Detection Query

```ruby
index=* EventCode=1
ParentImage="*services.exe"
| table _time host ParentImage Image CommandLine User
```

---

# Why This Detection Matters

This behavior is strongly associated with:

- PsExec
- Impacket
- CrackMapExec
- SMBExec
- Ransomware lateral movement

---

# 3. Encoded PowerShell Execution

Simulated attacker PowerShell execution.

## Encoded PowerShell Command

```ruby
powershell -enc dwBoAG8AYQBtAGkA
```

(Base64 decodes to: `whoami`)

---

# Remote Encoded PowerShell Execution

```ruby
crackmapexec smb 192.168.x.x -u helpdesk -p 'Password123!' -x "powershell -enc dwBoAG8AYQBtAGkA"
```
![img11-powershell-command](screenshots/img11-powershell-command.png)

---

# Telemetry Generated

Generated:

- powershell.exe execution
- Encoded command visibility
- Sysmon process creation logs

---

# PowerShell Detection Queries

## Detect PowerShell Execution

```ruby
index=* EventCode=1 Image="*powershell.exe"
| table _time host User ParentImage CommandLine
```

![img20-powershell-code1](screenshots/img20-powershell-code1.png)

---

## Detect Encoded PowerShell

```ruby
index=* EventCode=1
Image="*powershell.exe"
(CommandLine="*-enc*" OR CommandLine="*EncodedCommand*")
| table _time host User ParentImage CommandLine
```
![img20-enc-powershell](screenshots/img20-enc-powershell.png)


---

# Process Creation Hunting

---

# Important Parent-Child Relationships

## services.exe → cmd.exe

Highly suspicious relationship commonly associated with:

- Lateral movement
- Remote execution
- PsExec-style execution
- Administrative abuse

---

## Detection Query

```ruby
index=* EventCode=1
ParentImage="*services.exe"
(Image="*cmd.exe" OR Image="*powershell.exe")
| table _time host User ParentImage Image CommandLine
```

![img20-parent-child](screenshots/img20-parent-child.png)

---

# SMB Authentication Detection

## Successful SMB Logons

```ruby
index=* EventCode=4624 Logon_Type=3
| table _time host Account_Name Source_Network_Address Authentication_Package
```

![img20-success-logged](screenshots/img20-success-logged.png)

![img6-login-success](screenshots/img6-login-success.png)

![img7-login-success](screenshots/img7-login-success.png)

---

## Failed SMB Logons

```ruby
index=* EventCode=4625 Logon_Type=3
| stats count by Source_Network_Address Account_Name
| where count > 5
```
![img20-14-failed](screenshots/img20-14-failed.png)

![img20-view-events](screenshots/img20-view-events.png)

![img21-view-events2](screenshots/img21-view-events2.png)


---

# Detect Successful Login After Failures

```ruby
index=* (EventCode=4624 OR EventCode=4625)
| transaction Source_Network_Address maxspan=5m
| search EventCode=4625 EventCode=4624
| table _time host Account_Name Logon_Type Source_Network_Address EventCode
```

![img20-maxspan](screenshots/img20-maxspan.png)

---

# Threat Hunting Examples

## Hunt PowerShell Abuse

```ruby
index=* EventCode=1 Image="*powershell.exe"
```

---

## Hunt Encoded Commands

```ruby
index=* EventCode=1 CommandLine="*-enc*"
```

---

## Hunt Lateral Movement

```ruby
index=* EventCode=1 ParentImage="*services.exe"
```

---

## Hunt Suspicious Parent-Child Chains

```ruby
index=* EventCode=1
(Image="*powershell.exe" OR Image="*cmd.exe")
| stats count by ParentImage Image
| sort - count
```

---

# Realistic SOC Detections Demonstrated

This lab successfully simulated and detected:

- SMB authentication attacks
- Password spraying behavior
- Remote service execution
- Lateral movement activity
- PowerShell abuse
- Encoded PowerShell execution
- Suspicious parent-child relationships
- Administrative execution chains

---

# Key Detection Concepts Learned

## 1. Parent-Child Process Analysis

Understanding which process launched another process is critical for:

- Malware analysis
- Threat hunting
- Lateral movement detection

Examples:

| Parent Process | Child Process | Meaning |
|---|---|---|
| services.exe | cmd.exe | Remote execution |
| services.exe | powershell.exe | Lateral movement |
| explorer.exe | cmd.exe | User interactive shell |
| winword.exe | powershell.exe | Potential phishing |

---

## 2. Sysmon Visibility

Sysmon provided significantly better telemetry than default Windows logging, including:

- Full command lines
- Process GUIDs
- Parent process tracking
- Network connections
- Process hashes

---

## 3. PowerShell Detection Challenges

Observed that:

- Not all remote PowerShell executions generated Event ID 4104
- Sysmon Event ID 1 still provided strong visibility into PowerShell activity

---

# MITRE ATT&CK Mapping

| Technique | Description |
|---|---|
| T1021.002 | SMB/Windows Admin Shares |
| T1059.001 | PowerShell |
| T1059.003 | Windows Command Shell |
| T1078 | Valid Accounts |
| T1021 | Remote Services |
| T1105 | Ingress Tool Transfer |

---

# Skills Demonstrated

- SIEM Engineering
- Splunk Administration
- Windows Event Analysis
- Sysmon Deployment
- Threat Hunting
- Detection Engineering
- PowerShell Detection
- Endpoint Telemetry Analysis
- Windows Security Monitoring
- MITRE ATT&CK Mapping
- Lateral Movement Detection

---

# Challenges Encountered

## RDP Limitations

The Windows target was Windows Home edition, which does not support inbound RDP hosting.

Adjusted attack simulation to use:

- SMB authentication
- Remote service execution
- CrackMapExec

This still produced highly realistic attacker telemetry.

---

## Network Troubleshooting

Resolved:

- Bridged adapter networking issues
- VM-to-host communication problems
- Windows firewall filtering
- SMB connectivity validation

---

# Lessons Learned

## Importance of Endpoint Telemetry

Without Sysmon, many attacker behaviors would have limited visibility.

Sysmon dramatically improved:

- Process visibility
- Command-line auditing
- Lateral movement detection

---

## Realistic Detection Engineering

In this lab I have demonstrated that effective SOC monitoring depends on:

- Strong telemetry
- Contextual process analysis
- Parent-child relationships
- Behavioral detections

---

# Future Improvements

Planned future enhancements:

- Add Windows Server domain controller
- Simulate Kerberoasting
- Add Splunk Enterprise Security
- Deploy Sigma rules
- Build correlation searches
- Create detection dashboards
- Simulate ransomware encryption behavior
- Add persistence techniques
- Integrate Atomic Red Team testing

---

# Conclusion

This project demonstrates practical SOC analyst and detection engineering capabilities through realistic attacker simulation and telemetry analysis.

The lab successfully reproduced:

- SMB authentication attacks
- Lateral movement behavior
- Remote execution artifacts
- PowerShell abuse
- Threat hunting workflows

using Splunk and Sysmon in a Windows environment.

This project strengthened my hands-on experience with:

- SIEM operations
- Endpoint monitoring
- Detection engineering
- Threat hunting
- Windows security telemetry
- SOC workflows

---
