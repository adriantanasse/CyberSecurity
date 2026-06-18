# Enterprise Endpoint Management with Microsoft Intune

[![Windows](https://custom-icon-badges.demolab.com/badge/Windows-0078D6?logo=windows11&logoColor=white)](#)

## 📌 Project Overview

This project demonstrates the deployment and management of Windows devices using **Microsoft Intune and Microsoft Entra ID**.

The lab simulates a real-world enterprise environment where devices are enrolled into Intune, security and compliance policies are enforced, configuration profiles are deployed, and applications are automatically installed and managed.

---

## 👷‍♂️ Project Architecture


                Microsoft Entra ID
                         |
                         |
                    Microsoft Intune
                         |
       -------------------------------------
       |                |                  |
   Windows 11      Security Policies   Applications
      Device            Compliance      Deployment


---

## ⚙️ Technologies Used

✅ Microsoft Intune<br>
✅ Microsoft Entra ID (Azure AD)<br>
✅ Windows 11 VM<br>
✅ Microsoft 365 Apps<br>
✅ Endpoint Security Policies<br>
✅ Device Compliance Policies<br>
✅ Configuration Profiles

---

# Phase 1 – Enable Microsoft Intune

Microsoft Intune was enabled and configured within the Microsoft 365 tenant to provide centralized endpoint management.

### Screenshot

![Enable Intune](screenshots/enable-intune.png)

---

# Phase 2 – Configure Enrollment Restrictions

Enrollment restrictions were configured to control which devices are allowed to enroll into the environment.

This ensures only approved devices can be managed by the organization.

### Screenshot

![Enrollment Restrictions](screenshots/enrollment-restrictions.png)

---

# Phase 3 – Create Device Compliance Policy

A Windows compliance policy was created to evaluate device health and security requirements.

Configured checks included:

✅ Device encryption<br>
✅ Firewall status<br>
✅ Antivirus protection<br>
✅ Minimum OS requirements

### Screenshots

![Create Compliance Policy](screenshots/entra-create-compliant-policy.png)

![Policy Configuration](screenshots/create-policy-1.png)

![Policy Settings](screenshots/create-policy-2.png)

![Policy Created](screenshots/policy-created.png)

---

# Phase 4 – Verify Device Compliance

After policy deployment, enrolled devices were evaluated for compliance.

The device successfully reported as compliant.

### Screenshots

![Device Compliant](screenshots/device-compliant.png)

![Compliance Validation](screenshots/check-device-compliant.png)

---

# Phase 5 – Create Configuration Profile

A Windows configuration profile was created to standardize endpoint settings across managed devices.

The profile was used to restrict access to Control Panel settings.

### Screenshots

![Create Device Profile](screenshots/create-device-profile.png)

![Configuration Settings](screenshots/config-hide-control-panel.png)

![Profile Created](screenshots/device-profile-created.png)

---

# Phase 6 – Configure Endpoint Security

Endpoint Security policies were created to strengthen device security and enforce enterprise security standards.

Examples include:

✅ Microsoft Defender settings<br>
✅ Security baselines<br>
✅ Device restrictions

### Screenshots

![Endpoint Policies](screenshots/endpoint-policies.png)

![Endpoint Security Policy](screenshots/endpoint-security-policy.png)

---

# Phase 7 – Enroll Windows Device

A Windows 11 device was enrolled into Microsoft Intune through Microsoft Entra ID.

This validates that Intune can successfully manage enterprise endpoints.

### Screenshots

![Device Connected](screenshots/user-connected-win.png)

![MDM Verification](screenshots/check-user-mdm-win.png)

---

# Phase 8 – Deploy Applications

Applications were deployed through Intune and assigned to users automatically.

Applications deployed:

✅ Microsoft 365 Apps<br>
✅ Microsoft Store Applications (To Do, Teams)

### Screenshots

![Applications Added](screenshots/apps-added.png)

![Deploy Microsoft 365](screenshots/deploy-365.png)

---

# Phase 9 – Validate Application Deployment

Application installation was tested on the enrolled Windows device.

The deployment completed successfully without requiring manual installation.

### Screenshots

![M365 Installed](screenshots/m365-installation-test-win.png)

![Installation Report](screenshots/intune-apps-installation-report.png)

---

# Phase 10 – Test Policy Enforcement

Policy enforcement was validated on the Windows endpoint.

Tests included:

✅ Restart validation<br>
✅ Device compliance review<br>
✅ User experience verification

### Screenshots

![Restart Test](screenshots/restart-vm-test.png)

![User Testing](screenshots/user-testing.png)

![Policies](screenshots/policies-entra.png)

---

# Key Skills Demonstrated

- Microsoft Intune Administration
- Microsoft Entra ID Administration
- Windows Device Enrollment
- Mobile Device Management (MDM)
- Endpoint Security Configuration
- Compliance Policy Management
- Application Deployment
- Configuration Profile Deployment
- Enterprise Endpoint Management
- Troubleshooting and Validation

---

# Outcome

Successfully deployed and managed a Windows endpoint using Microsoft Intune and Microsoft Entra ID. The environment demonstrates enterprise-level endpoint management capabilities including device enrollment, compliance monitoring, security policy enforcement, configuration management, and automated software deployment.