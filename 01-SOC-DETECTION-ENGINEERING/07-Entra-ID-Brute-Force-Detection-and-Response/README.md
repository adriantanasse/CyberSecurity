# Entra ID Brute Force Detection and Response with Microsoft Defender XDR

![KQL](https://img.shields.io/badge/KQL-content?style=plastic&label=Microsoft&labelColor=%2357606a&color=%230078D4)
![Microsoft Sentinel](https://img.shields.io/badge/Microsoft-Sentinel-blue)
![Defender XDR](https://img.shields.io/badge/Defender-XDR-green)
[![Microsoft Azure](https://custom-icon-badges.demolab.com/badge/Microsoft%20Azure-0089D6?logo=msazure&logoColor=white)](#)
[![Windows](https://custom-icon-badges.demolab.com/badge/Windows-0078D6?logo=windows11&logoColor=white)](#)

## 📌 Project Overview

This project demonstrates the detection, investigation, and response to a simulated Entra ID password spray (brute force) attack using Microsoft Defender XDR and Microsoft Sentinel.

The objective was to emulate an attacker attempting to gain access to Microsoft 365 accounts using password spraying techniques from a Kali Linux system and then detect, investigate, correlate, and remediate the activity using Microsoft's security stack.

## ⚙️ Technologies Used

- Microsoft Entra ID
- Microsoft Defender XDR
- Microsoft Sentinel
- Microsoft Defender for Identity
- Microsoft 365
- Kali Linux
- KQL (Kusto Query Language)
- Incident Correlation
- Identity Protection

---

## Attack Scenario

A simulated attacker used Kali Linux to perform password spraying attempts against a Microsoft 365 tenant.

The attack generated multiple failed authentication events which were collected and analyzed through Microsoft Defender XDR and Microsoft Sentinel.

Custom detection rules were configured to identify password spray behavior and automatically generate alerts for investigation.

---

# Phase 1 – Attack Simulation

## Step 1: Execute Password Spray Activity

A password spraying attack was launched from Kali Linux against Entra ID accounts to generate authentication failures and security telemetry.

### Screenshot

![Spraying Check](screenshots/spraying-check.png)

![Spraying Successful Login](screenshots/spraying-successful-login.png)


---

## Step 2: Validate Attack Activity

Authentication activity was validated to confirm that failed sign-in events were being generated and forwarded to Microsoft security platforms.

### Screenshot

![Password Spray Attack](screenshots/run-attack-again.png)

---

# Phase 2 – Detection Engineering

## Step 3: Create Custom Detection Rule

A custom Defender XDR detection rule was created to identify password spraying behavior based on multiple failed authentication attempts from a single source.

### Screenshot

![Brute Force Detection Rule](screenshots/brute-force-detection-rule-1.png)

### Screenshot

![Detection Rule Created](screenshots/brute-force-detection-created.png)

---

## Step 4: Create Sentinel Detection Query

A custom KQL detection query was created in Microsoft Sentinel to identify authentication anomalies and correlate failed sign-in activity.

### Screenshot

![Sentinel Detection Query](screenshots/sentinel-bruteforce-query.png)

---

# Phase 3 – Alert Generation

## Step 5: Generate Security Alerts

Once attack activity was detected, Microsoft Defender XDR generated security alerts indicating suspicious authentication behavior.

### Screenshot

![Detection Alert 1](screenshots/defender-spray-detection-alert-1.png)

### Screenshot

![Detection Alert 2](screenshots/defender-spray-detection-alert-2.png)

---

## Step 6: Correlate Authentication Events

Authentication logs were correlated to identify attack patterns and determine affected user accounts.

### Screenshot

![Failed Login Correlation](screenshots/entra-id-failed-logins-correlation.png)

### Screenshot

![Correlation Analysis](screenshots/incident-correlation.png)

---

# Phase 4 – Incident Investigation

## Step 7: Create Incident

The generated alerts were automatically grouped into a security incident for investigation and response.

### Screenshot

![Incident Generated](screenshots/incident-generated.png)

---

## Step 8: Review Incident Summary

Incident data was reviewed to determine the scope of the attack, affected identities, and source indicators.

### Screenshot

![Incident Summary](screenshots/incident-summary.png)

---

## Step 9: Investigate User Activity

User activity was analyzed through Microsoft Defender XDR to determine whether any successful compromise occurred.

### Screenshot

![User Investigation](screenshots/user-defender-investigation.png)

---

# Phase 5 – Response and Remediation

## Step 10: Perform Remediation Actions

Response actions were executed to contain the threat and reduce the likelihood of further compromise.

Examples included:

- Investigating affected accounts
- Reviewing sign-in activity
- Resetting passwords
- Validating MFA configuration
- Monitoring for continued attack attempts

### Screenshot

![Remediation Complete](screenshots/remediation-complete.png)

---

# Security Outcomes

This project demonstrates practical experience with:

- Entra ID Identity Monitoring
- Password Spray Detection
- Brute Force Attack Analysis
- Microsoft Defender XDR
- Microsoft Sentinel
- KQL Query Development
- Alert Triage
- Incident Investigation
- Threat Hunting
- Incident Response
- Identity Security Operations

---

# Key Skills Demonstrated

- Detection Engineering
- Security Monitoring
- Microsoft Defender XDR
- Microsoft Sentinel
- Entra ID Security
- KQL Query Writing
- Threat Detection
- Incident Correlation
- Identity Protection
- SOC Analyst Workflows
- Incident Response