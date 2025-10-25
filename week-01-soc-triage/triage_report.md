# SOC Triage Exercise

**Author:** Adrian Tanase
**Date:** 2025-10-25  

**Environment:** Local lab (MacOSx target VM (Vagrant) at `10.0.0.5` — NAT/host-only).  
**Tools used:** tcpdump, Wireshark, tshark, Splunk Free, triage-script.sh

**Goal:** capture network traffic, produce /var/log evidence for failed logins, inspect Windows event logs, ingest Linux logs into a local Splunk, and produce a 1-page triage note.

**Pen-test Required Tasks:**
1. Create an Ubuntu VM (Vagrant) for a target host.
2. (Optional) Bring up a Windows evaluation VM (for event logs).
3. Use Wireshark and tshark to capture traffic on the host-only network.
4. Generate SSH failed logins from an attacker VM (or Mac host).
5. Run triage script on target Ubuntu to collect logs & artifacts.
6. Install Splunk (local) and ingest `/var/log/auth.log` to make a basic detection rule for repeated SSH failures.


---

## Summary
At 2025-10-25 20:33:12 UTC, the test target observed a burst of failed SSH authentication attempts from a remote host. Network captures show repeated TCP connections to port 22. Host logs contain repeated `Failed password` events. No successful authentication observed.

## Attacker
    Mac:sec-porto adriantanase$ TARGET=10.0.0.5; for i in {1..25}; do ssh -o ConnectTimeout=2 -o BatchMode=yes invaliduser@"$TARGET" 'echo hello' 2>/dev/null || true; done

<img width="752" height="304" alt="Group 1 (1)" src="https://github.com/user-attachments/assets/8d62e532-e771-4f25-a06d-0bde80fbe261" />


(If **pentest-user** will cause SSH to hang waiting for a password, add -o BatchMode=yes so ssh fails fast instead of prompting)

    sudo tail -n 200 /var/log/auth.log
    sudo grep "Failed password" /var/log/auth.log | tail -n 50


<img width="796" height="471" alt="Group 3" src="https://github.com/user-attachments/assets/19aefe41-8c9a-44a5-8118-241f90618106" />


## Evidence (sanitized excerpts)
    **/var/log/auth.log** (excerpt, IPs anonymized):
    Oct 25 20:33:26 vultr sshd[2060]: Failed password for root from `10.0.0.5` port 42010 ssh2
    Oct 25 20:39:30 vultr sshd[2060]: Failed password for root from `10.0.0.5` port 42010 ssh2
    Oct 25 20:39:32 vultr sshd[2060]: Failed password for root from `10.0.0.5` port 42010 ssh2
    Oct 25 20:39:36 vultr sshd[2084]: Failed password for root from `10.0.0.5` port 14931 ssh2
    Oct 25 20:39:40 vultr sshd[2084]: Failed password for root from `10.0.0.5` port 14931 ssh2
    Oct 25 20:39:44 vultr sshd[2084]: Failed password for root from `10.0.0.5` port 14931 ssh2
    Oct 25 20:39:48 vultr sshd[2150]: Failed password for root from `10.0.0.5` port 20518 ssh2
    Oct 25 20:39:52 vultr sshd[2150]: Failed password for root from `10.0.0.5` port 20518 ssh2
    Oct 25 20:39:56 vultr sshd[2150]: Failed password for root from `10.0.0.5` port 20518 ssh2
    Oct 25 20:41:45 vultr sudo:     root : TTY=pts/0 ; PWD=/root/seclabs ; USER=root ; COMMAND=/usr/bin/grep Failed password /var/log/auth.log
    ...

**Network (Wireshark)**: TCP streams show multiple SYN, SYN/ACK, RST; no completed SSH handshakes.

## IOCs (synthetic)
- Attacker IP: `10.0.0.5` (RFC1918 used for lab)  
- Attempted usernames: `pentest-user`
- Related log lines: see `week-01-soc-triage/artifacts/authlog-excerpt.txt`

## Actions taken / recommended containment
1. Block source IP (`10.0.0.5`) at perimeter or host firewall.  
2. Confirm no successful logins; rotate credentials for any affected accounts.  
3. Preserve evidence: collected triage archive `triage-20251025-1430.tar.gz` (hash: `SHA256: <redacted>`) — archived offline.  
4. Tune detection: create SIEM rule to alert on >5 failed SSH attempts per 5 minutes (example Splunk query in `tshark-filters.txt`).  
5. If public keys were used anywhere, rotate keys and review authorized_keys.


## Notes on data
All logs and screenshots are sanitized to remove real IPs and any sensitive identifiers. This repository contains no customer data or private keys.
