# IR-002 — Unauthorized Local User Creation & Privilege Escalation

**Date:** 2026-05-13
**Analyst:** Erfan Nayeb Aghaei
**Severity:** Critical
**Status:** Resolved

---

## Executive Summary

A new local user account (HackerUser) was created on the Windows 11 victim machine and immediately added to the local Administrators group. This simulates a common post-exploitation persistence technique where an attacker creates a backdoor account with elevated privileges. Wazuh detected both the account creation and the privilege escalation in real time.

---

## Timeline

| Time | Event |
|---|---|
| T+0 | Command `net user HackerUser Password123! /add` executed |
| T+0 | Windows Event ID 4720 generated — user account created |
| T+5s | Wazuh Rule 60106 fired — Windows User Account Created |
| T+10s | Command `net localgroup Administrators HackerUser /add` executed |
| T+10s | Windows Event ID 4732 generated — user added to privileged group |
| T+15s | Wazuh Rule 60111 fired — User Added to Privileged Group |

---

## Attack Details

| Field | Value |
|---|---|
| Attack Type | Persistence / Privilege Escalation |
| MITRE Technique | T1136.001, T1078.003 |
| New Username | HackerUser |
| Group Added To | Administrators |
| Method | net user / net localgroup commands |

---

## Detection

| Event | Rule ID | Event ID | Description |
|---|---|---|---|
| User Created | 60106 | 4720 | Windows User Account Created |
| Added to Admins | 60111 | 4732 | User Added to Privileged Group |

---

## Indicators of Compromise (IOCs)

- New local account created: `HackerUser`
- Account immediately added to `Administrators` group
- Commands executed via `net.exe` (common LOLBin)
- Event IDs 4720 and 4732 in close succession

---

## Response Actions

1. Detected new account creation via Wazuh alert (Rule 60106)
2. Detected privilege escalation via Wazuh alert (Rule 60111)
3. Identified account name: HackerUser
4. Removed account: `net user HackerUser /delete`
5. Verified removal via `net localgroup Administrators`

---

## Recommendations

1. **Alert on any new local account creation** — in most environments this should never happen automatically
2. **Restrict net.exe usage** via AppLocker or Windows Defender Application Control
3. **Enable Just-In-Time (JIT) access** for admin privileges
4. **Monitor Administrators group membership** changes in real time
5. **Implement Privileged Access Workstations (PAW)** for admin tasks

---

## MITRE ATT&CK Mapping

| Tactic | Technique | ID |
|---|---|---|
| Persistence | Create Account: Local Account | T1136.001 |
| Privilege Escalation | Valid Accounts: Local Accounts | T1078.003 |
| Defense Evasion | Use Alternate Authentication Material | T1550 |
