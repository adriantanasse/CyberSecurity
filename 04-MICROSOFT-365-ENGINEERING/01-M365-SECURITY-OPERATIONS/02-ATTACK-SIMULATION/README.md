# Password Spray Investigation

## Alert Type

Password Spray Attempt

## Detection Source

Microsoft Entra Sign-In Logs

## Affected Users

- Brenda Smith
- Daniel Ezaru
- Gerard Miller
- Jennifer Spielberg

## Indicators

- Multiple failed logins
- Same source IP
- Same timeframe
- Multiple accounts targeted

## Findings

No successful authentication observed.

## Impact

No compromise detected.

## Recommendation

Continue enforcing MFA.
Monitor repeated activity from source IP.


# Incident Report

# Security Incident Report

## Incident

Password Spray Attack

## Date

2026-06-16

## Severity

Medium

## Detection Method

Microsoft Entra Sign-In Logs

## Findings

Multiple failed authentication attempts were observed against several user accounts from a single IP address.

## Affected Accounts

- Brenda Smith
- Daniel Ezaru
- Gerard Miller
- Jennifer Spielberg
- Michael Johnston

## Investigation Results

No successful authentication occurred.
Conditional Access and MFA protections remained effective.

## Remediation

No further action required.
Continue monitoring authentication activity.

## Status

Closed