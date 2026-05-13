# Attack Simulation — Suspicious PowerShell Execution

## MITRE ATT&CK
- **Tactic:** Execution
- **Technique:** T1059.001 — Command and Scripting Interpreter: PowerShell
- **Target:** Windows 11 Victim (192.168.56.106)

---

## Objective
Simulate malicious PowerShell activity including encoded commands and system reconnaissance — common techniques used by malware and threat actors to evade detection.

---

## Attack Commands

```powershell
# Encoded command execution (common malware evasion technique)
powershell -EncodedCommand aQBwAGMAbwBuAGYAaQBnAA==

# System reconnaissance via PowerShell
Get-LocalUser
Get-LocalGroupMember Administrators
netstat -ano

# Download cradle simulation (common in fileless malware)
powershell -ExecutionPolicy Bypass -NoProfile -Command "IEX (New-Object Net.WebClient)"
```

---

## Prerequisites
Enable PowerShell Script Block Logging on victim:

```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v EnableScriptBlockLogging /t REG_DWORD /d 1 /f
```

---

## Expected Wazuh Detection

| Field | Value |
|---|---|
| Rule ID | 91801 |
| Rule Description | Suspicious PowerShell execution |
| Windows Event ID | 4104 |
| Agent | Windows11Victim |

---
