# IR-001 — RDP Brute Force Attack

**Date:** 2026-05-11
**Analyst:** Erfan Nayeb Aghaei
**Severity:** High
**Status:** Resolved

---

## Executive Summary

A brute force attack targeting the Remote Desktop Protocol (RDP) service was detected on the Windows 11 victim machine (192.168.56.106). The attack originated from the Kali Linux attacker machine (192.168.56.104) using the Hydra tool with the rockyou.txt wordlist. Wazuh successfully detected the attack through multiple failed logon event ID 4625 alerts.

---

## Timeline

| Time | Event |
|---|---|
| 13:29 | Nmap scan confirmed port 3389 open on victim |
| 13:30 | Hydra RDP brute force started from Kali (192.168.56.104) |
| 13:30 | Wazuh began generating Event ID 4625 alerts |
| 13:31 | Rule 60122 fired — Multiple Windows Logon Failures |
| 13:35 | Attack stopped — no successful authentication |

---

## Attack Details

| Field | Value |
|---|---|
| Attack Type | RDP Brute Force |
| MITRE Technique | T1110.001 |
| Source IP | 192.168.56.104 (Kali) |
| Destination IP | 192.168.56.106 (Windows 11) |
| Target Port | 3389 (RDP) |
| Target Username | administrator |
| Tool Used | Hydra |
| Wordlist | rockyou.txt |
| Result | Failed — no valid credentials found |

---

## Detection

| Field | Value |
|---|---|
| SIEM | Wazuh 4.14 |
| Rule ID | 60122 |
| Rule Description | Multiple Windows Logon Failures |
| Rule Level | 10 (High) |
| Windows Event ID | 4625 |
| Detection Time | < 60 seconds after attack start |

---

## Indicators of Compromise (IOCs)

- Source IP: `192.168.56.104`
- Multiple Event ID 4625 from single source in short timeframe
- Target: `administrator` account
- Port: `3389/tcp`

---

## Response Actions

1. Identified source IP of brute force (192.168.56.104)
2. Confirmed no successful authentication (no Event ID 4624)
3. Verified attack stopped with no persistence established

---

## Recommendations

1. **Disable RDP** if not required, or restrict to specific IPs via firewall
2. **Enable Account Lockout Policy** — lock account after 5 failed attempts
3. **Enforce MFA** on RDP access
4. **Change default port** from 3389 to a non-standard port
5. **Use VPN** to gate RDP access rather than exposing it directly

---

## MITRE ATT&CK Mapping

| Tactic | Technique | ID |
|---|---|---|
| Credential Access | Brute Force: Password Guessing | T1110.001 |
| Reconnaissance | Active Scanning: Network Service Scanning | T1046 |
