# Attack Simulation — SMB Enumeration

## MITRE ATT&CK
- **Tactic:** Discovery
- **Technique:** T1135 — Network Share Discovery
- **Target:** Windows 11 Victim (192.168.56.106)
- **Tools:** smbclient, enum4linux, nmap

---

## Objective
Enumerate SMB shares and system information from the victim machine to simulate reconnaissance activity a threat actor would perform after initial access.

---

## Attack Commands

```bash
# Attempt anonymous SMB access
smbclient -L //192.168.56.106 -N

# Full enumeration
enum4linux -a 192.168.56.106

# NSE script scan
nmap --script smb-vuln-ms17-010 192.168.56.106
nmap --script smb-enum-shares 192.168.56.106
```

---

## Result
Anonymous SMB access was denied — `NT_STATUS_ACCESS_DENIED`

This indicates the target is hardened against unauthenticated enumeration, which is the expected secure configuration for Windows 11.

---

## Expected Wazuh Detection

| Field | Value |
|---|---|
| Rule ID | 18116 |
| Rule Description | Samba: Attempt to login with null username/password |
| Windows Event ID | 4625 / 5145 |
| Agent | Windows11Victim |

---

## Screenshots
See `../../screenshots/` folder:
- `11-smb-anonymous-access-denied.png`
