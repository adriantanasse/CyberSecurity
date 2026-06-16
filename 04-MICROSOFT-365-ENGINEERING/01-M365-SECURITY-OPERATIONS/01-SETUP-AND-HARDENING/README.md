# Phase 1 - Tenant Setup

## Company

TancoMedia

## Users Created

| User | Department | Role |
|--------|------------|--------|
| Brenda Smith | IT Support | IT Support Engineer |
| Daniel Ezaru | IT Support | IT Support Manager |
| Gerard Miller | HR | HR Manager |
| Jennifer Spielberg | HR | HR Talent Recruiter |
| Michael Johnston | Finance | Financial Analyst |

![users-created](screenshots/users-created.png)

## Security Groups

| Group |
|--------|
| IT Support |
| HR |
| Finance |
| MFA Required |

![groups-created](screenshots/groups-created.png)

## Validation

- Users successfully created
- Security groups created
- Members assigned
- Microsoft 365 licensing verified

![license-assigned](screenshots/license-assigned.png)

# Phase 2 - Multi-Factor Authentication

## Objective

Protect user accounts using Conditional Access and MFA.

## Policy Created

Require MFA For Employees

![mfa-policy-created](screenshots/mfa-policy-created.png)

![mfa-policy-created-2](screenshots/mfa-policy-created-2.png)

## Scope

Users in MFA Required group

## Exclusions

Emergency Admin

## Authentication Method

Microsoft Authenticator

## Validation

- MFA enrollment completed
- MFA challenge successful
- Conditional Access policy applied
- Sign-in logs verified

![mfa-successful-login](screenshots/mfa-successful-login.png)

![mfa-successful-login-2](screenshots/mfa-successful-login-2.png)

## Security Benefit

MFA protects accounts from password theft, credential stuffing, and password spray attacks.

# Phase 3 - Conditional Access Hardening

## Objective

Strengthen identity security using Microsoft Entra Conditional Access.

## Policies Implemented

### Require MFA For Employees

- Targeted MFA Required Group
- Enforced MFA for standard users

### Require MFA For Administrators

- Targeted Global Administrators
- Enforced MFA for privileged accounts

### Block Legacy Authentication

- Blocked Exchange ActiveSync
- Blocked legacy authentication protocols

### Require MFA For Finance Users

- Added additional protection for high-value users

## Security Benefits

- Reduced credential theft risk
- Protected privileged accounts
- Eliminated legacy authentication attack paths
- Strengthened identity security posture

## Evidence

- conditional-access-policies.png
- admin-mfa-policy-details.png
- legacy-auth-policy-details.png