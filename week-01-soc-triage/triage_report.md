# Week 01 — SOC Triage Exercise (1-page report)

**Author:** Adrian Tanase
**Date:** 2025-10-25  

**Environment:** Local lab (MacOSx target VM at 192.168.178.21 — NAT/host-only).  
**Tools used:** tcpdump, Wireshark, tshark, Splunk Free, triage-script.sh

---

## Summary
At 2025-10-25 14:32:12 UTC, the test target observed a burst of failed SSH authentication attempts from a remote host. Network captures show repeated TCP connections to port 22. Host logs contain repeated `Failed password` events. No successful authentication observed.

## Attacker
Mac:sec-porto adriantanase$ TARGET=10.0.0.5; for i in {1..25}; do ssh -o ConnectTimeout=2 -o BatchMode=yes invaliduser@"$TARGET" 'echo hello' 2>/dev/null || true; done

(If invaliduser will cause SSH to hang waiting for a password, add -o BatchMode=yes so ssh fails fast instead of prompting)

sudo tail -n 200 /var/log/auth.log

sudo grep "Failed password" /var/log/auth.log | tail -n 50

## Evidence (sanitized excerpts)
**/var/log/auth.log** (excerpt, IPs anonymized):
Oct 24 23:56:37 vultr sshd[49572]: Failed password for root from 10.0.0.5 port 45888 ssh2
Oct 25 00:13:45 vultr sshd[49936]: Failed password for root from 10.0.0.5 port 12582 ssh2
Oct 25 00:13:47 vultr sshd[49936]: Failed password for root from 10.0.0.5 port 12582 ssh2
Oct 25 00:13:49 vultr sshd[49936]: Failed password for root from 10.0.0.5 port 12582 ssh2
Oct 25 00:13:54 vultr sshd[49938]: Failed password for root from 10.0.0.5 port 64398 ssh2
Oct 25 00:13:56 vultr sshd[49938]: Failed password for root from 10.0.0.5 port 64398 ssh2
Oct 25 00:13:59 vultr sshd[49938]: Failed password for root from 10.0.0.5 port 64398 ssh2
Oct 25 00:14:02 vultr sshd[49940]: Failed password for root from 10.0.0.5 port 57368 ssh2
Oct 25 00:14:06 vultr sshd[49940]: Failed password for root from 10.0.0.5 port 57368 ssh2
Oct 25 00:14:09 vultr sshd[49940]: Failed password for root from 10.0.0.5 port 57368 ssh2
Oct 25 00:17:49 vultr sudo:     root : TTY=pts/0 ; PWD=/root ; USER=root ; COMMAND=/usr/bin/grep Failed password /var/log/auth.log
root@vultr:~# 

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

<img width="1277" height="726" alt="Screenshot 2025-10-25 at 2 41 11 AM" src="https://github.com/user-attachments/assets/1db57f2f-bfa3-448d-9117-4e5673cb13c9" />

<img width="648" height="378" alt="Screenshot 2025-10-25 at 2 40 56 AM" src="https://github.com/user-attachments/assets/0e52df30-a574-4260-b498-e1c119b2fb3c" />



## Notes on data
All logs and screenshots are sanitized to remove real IPs and any sensitive identifiers. This repository contains no customer data or private keys.
