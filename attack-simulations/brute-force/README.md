# Attack Simulation 01 — RDP Brute Force

## MITRE ATT&CK
- **Tactic:** Credential Access
- **Technique:** T1110.001 — Brute Force: Password Guessing
- **Target:** Windows 11 Victim (192.168.56.106)
- **Tool:** Hydra

---

## Objective
Simulate a brute force attack against the RDP service on the victim machine and verify Wazuh detects the failed authentication attempts.

---

## Prerequisites
- RDP enabled on Windows 11 victim
- Port 3389 open and reachable from Kali
- Wazuh agent active on Windows 11 victim
- Sysmon running on Windows 11 victim

---

## Attack Command

```bash
hydra -l administrator -P /usr/share/wordlists/rockyou.txt rdp://192.168.56.106 -t 4 -W 3
```

### Parameters explained
| Flag | Meaning |
|---|---|
| `-l administrator` | Target username |
| `-P rockyou.txt` | Password wordlist |
| `-t 4` | 4 parallel threads |
| `-W 3` | Wait 3 seconds between attempts |

---

## Expected Wazuh Detection

| Field | Value |
|---|---|
| Rule ID | 60122 |
| Rule Description | Multiple Windows Logon Failures |
| Rule Level | 10 |
| Windows Event ID | 4625 |
| Agent | Windows11Victim |

---

## Incident Report
See [`../../reports/IR-001-rdp-bruteforce.md`](../../reports/IR-001-rdp-bruteforce.md)
