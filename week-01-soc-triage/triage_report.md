# Week 01 — SOC Triage Exercise (1-page report)

**Author:** Adrian Tanase
**Date:** 2025-10-25  
**Environment:** Local lab (Ubuntu 20.04 target VM at 192.168.56.20 — NAT/host-only).  
**Tools used:** tcpdump, Wireshark, tshark, Splunk Free, triage-script.sh

---

## Summary
At 2025-10-25 14:32:12 UTC, the test target observed a burst of failed SSH authentication attempts from a remote host. Network captures show repeated TCP connections to port 22. Host logs contain repeated `Failed password` events. No successful authentication observed.

## Evidence (sanitized excerpts)
**/var/log/auth.log** (excerpt, IPs anonymized):
Oct 25 14:31:50 target sshd[1234]: Failed password for invalid user testuser from 10.0.0.5 port 53412 ssh2
Oct 25 14:31:51 target sshd[1234]: Failed password for invalid user testuser from 10.0.0.5 port 53413 ssh2
...


**Network (Wireshark)**: TCP streams show multiple SYN, SYN/ACK, RST; no completed SSH handshakes. (Screenshot: `screenshots/wireshark-ssh.png`)

## IOCs (synthetic)
- Attacker IP: `10.0.0.5` (RFC1918 used for lab)  
- Attempted usernames: `invaliduser`, `testuser`  
- Related log lines: see `week-01-soc-triage/artifacts/authlog-excerpt.txt`

## Actions taken / recommended containment
1. Block source IP (`10.0.0.5`) at perimeter or host firewall.  
2. Confirm no successful logins; rotate credentials for any affected accounts.  
3. Preserve evidence: collected triage archive `triage-20251025-1430.tar.gz` (hash: `SHA256: <redacted>`) — archived offline.  
4. Tune detection: create SIEM rule to alert on >5 failed SSH attempts per 5 minutes (example Splunk query in `tshark-filters.txt`).  
5. If public keys were used anywhere, rotate keys and review authorized_keys.

## Notes on data
All logs and screenshots are sanitized to remove real IPs and any sensitive identifiers. This repository contains no customer data or private keys.
