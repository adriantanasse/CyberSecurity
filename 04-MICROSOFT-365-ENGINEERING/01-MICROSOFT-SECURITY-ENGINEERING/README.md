# Microsoft 365 Security Engineering Lab

![KQL](https://img.shields.io/badge/KQL-content?style=plastic&label=Microsoft&labelColor=%2357606a&color=%230078D4)
![Microsoft Sentinel](https://img.shields.io/badge/Microsoft-Sentinel-blue)
![Defender XDR](https://img.shields.io/badge/Defender-XDR-green)
[![Microsoft Azure](https://custom-icon-badges.demolab.com/badge/Microsoft%20Azure-0089D6?logo=msazure&logoColor=white)](#)
[![Windows](https://custom-icon-badges.demolab.com/badge/Windows-0078D6?logo=windows11&logoColor=white)](#)


> A hands-on Microsoft security lab focused on identity protection, threat detection, threat hunting, incident response, and security operations using Microsoft Entra ID, Microsoft Defender XDR, Microsoft Sentinel, and KQL.

This repository documents the practical implementation of Microsoft security technologies across multiple phases, simulating real-world scenarios encountered by:

- Security Operations Center (SOC) Analysts
- Security Engineers
- Cloud Security Engineers
- Microsoft 365 Administrators
- IT Support & Systems Administrators
- Detection Engineers
- Blue Team Analysts

---

## Objectives

This lab was built to gain practical experience with Microsoft's security ecosystem while developing skills in:

- Identity and Access Management (IAM)
- Security Hardening
- Threat Detection Engineering
- Threat Hunting
- Incident Investigation
- Security Monitoring
- SIEM & XDR Operations
- Kusto Query Language (KQL)
- MITRE ATT&CK Mapping
- Security Analytics

---

## Environment

| Component | Technology |
|------------|------------|
| Identity Provider | Microsoft Entra ID |
| Security Platform | Microsoft Defender XDR |
| SIEM | Microsoft Sentinel |
| Log Analytics | Azure Log Analytics Workspace |
| Query Language | KQL |
| Detection Framework | MITRE ATT&CK |
| Cloud Platform | Microsoft Azure |
| Endpoint & Identity Telemetry | Microsoft Defender XDR |

---

# Lab Phases

## 01 – Entra ID Setup & Hardening

**Focus:** Identity Management & Security Baselines

### Topics Covered

- Microsoft Entra ID deployment
- User and group administration
- Administrative role assignments
- MFA implementation
- Conditional Access policies
- Identity security best practices
- Access control hardening
- Tenant security configuration

### Skills Developed

- Identity Administration
- Microsoft 365 Administration
- IAM Security
- Access Management
- Security Baseline Implementation

---

## 02 – Identity Threat Detection

**Focus:** Identity-Based Threat Monitoring

### Topics Covered

- Failed authentication analysis
- Risky sign-in investigation
- User sign-in monitoring
- Suspicious authentication activity
- Identity attack scenarios
- Microsoft Defender XDR investigations

### Skills Developed

- Identity Threat Detection
- Security Monitoring
- Incident Triage
- Threat Analysis
- Authentication Security

---

## 03 – KQL Threat Hunting

**Focus:** Advanced Hunting & Detection Logic

### Topics Covered

- Defender XDR Advanced Hunting
- Kusto Query Language (KQL)
- Authentication event analysis
- Log correlation
- User activity investigations
- Security data exploration

### Example Hunts

- Failed sign-in analysis
- User activity correlation
- Source IP investigations
- Authentication anomaly detection
- Credential access monitoring

### Skills Developed

- Threat Hunting
- KQL Development
- Log Analytics
- Detection Engineering
- Security Investigation

---

## 04 – Sentinel & Defender XDR Threat Hunting

**Focus:** SIEM + XDR Integration & Detection Engineering

### Topics Covered

- Microsoft Sentinel deployment
- Defender XDR integration
- Log Analytics Workspace configuration
- Data connector validation
- Advanced Hunting integration
- Custom detection rule development
- Incident generation and investigation

### Custom Detections Created

#### Multiple Failed Sign-ins Detection

Detects repeated failed authentication attempts against a single account.

**MITRE ATT&CK**
- T1110 – Brute Force

#### Password Spray Detection

Detects multiple failed authentication attempts originating from a single IP address targeting multiple accounts.

**MITRE ATT&CK**
- T1110.003 – Password Spraying

### Investigation Workflow

1. Authentication logs collected
2. KQL queries identify suspicious activity
3. Detection rules generate alerts
4. Defender XDR correlates incidents
5. Analysts investigate impacted users
6. Source IPs and authentication timelines reviewed
7. Incident response actions initiated

### Skills Developed

- SIEM Engineering
- Detection Engineering
- Threat Hunting
- Security Analytics
- Incident Response
- MITRE ATT&CK Mapping
- Microsoft Sentinel Administration

---

# Security Operations Workflow

```text
Microsoft Entra ID
        │
        ▼
Authentication Logs
        │
        ▼
Microsoft Sentinel
(Log Analytics Workspace)
        │
        ▼
KQL Threat Hunting
        │
        ▼
Custom Detection Rules
        │
        ▼
Microsoft Defender XDR
        │
        ▼
Alert Correlation
        │
        ▼
Incident Creation
        │
        ▼
Investigation & Response
```

---

# Skills Demonstrated

## IT Technical Support

- Microsoft 365 Administration
- User Account Management
- MFA Deployment
- Identity Troubleshooting
- Access Management
- Security Policy Administration
- Authentication Issue Analysis

## Technical Engineering

- Microsoft Azure Administration
- Microsoft Sentinel Deployment
- Log Analytics Configuration
- Security Architecture
- SIEM Engineering
- Detection Engineering
- Security Monitoring Design

## SOC Analyst

- Threat Hunting
- Incident Investigation
- Alert Triage
- KQL Query Development
- MITRE ATT&CK Mapping
- Credential Access Detection
- Security Monitoring
- Incident Response

---

# Technologies Used

- Microsoft Entra ID
- Microsoft Defender XDR
- Microsoft Sentinel
- Microsoft Azure
- Azure Log Analytics
- Kusto Query Language (KQL)
- Conditional Access
- Multi-Factor Authentication (MFA)
- MITRE ATT&CK Framework

---

# Roadmap

### Completed

- [x] Entra ID Deployment & Hardening
- [x] Conditional Access Implementation
- [x] Defender XDR Configuration
- [x] Advanced Hunting with KQL
- [x] Sentinel Deployment
- [x] Custom Detection Engineering
- [x] Incident Correlation & Investigation

### Planned

- [ ] SOAR Automation
- [ ] Logic Apps Integration
- [ ] Threat Intelligence Feeds
- [ ] Microsoft Defender for Cloud
- [ ] Automated Response Playbooks
- [ ] Advanced Detection Engineering
- [ ] Attack Simulation & Adversary Emulation

---

# Key Takeaway

This lab demonstrates how modern Microsoft security solutions can be combined to move from raw authentication telemetry to actionable threat detection, automated incident generation, and security investigations.

By integrating Microsoft Sentinel, Defender XDR, Entra ID, and KQL, the environment provides a realistic Security Operations Center (SOC) workflow for detecting and responding to identity-based threats such as brute force and password spraying attacks.

---

**Author:** Adrian Tanase  
**Focus Areas:** Microsoft Security • SOC Operations • Threat Hunting • Detection Engineering • Cloud Security • Identity Security