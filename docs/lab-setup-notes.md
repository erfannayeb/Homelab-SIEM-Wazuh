# Lab Setup Notes

## Host Machine
- **Model:** Asus ROG Strix G512LI
- **CPU:** Intel i7-10750H (6 cores / 12 threads)
- **RAM:** 16GB DDR4
- **Host OS:** Windows 11 Pro
- **Hypervisor:** Oracle VirtualBox

---

## VM Resource Allocation

| VM | RAM | CPU | Disk |
|---|---|---|---|
| Ubuntu Server 22.04 (Wazuh) | 4GB | 2 cores | 60GB |
| Windows 11 Pro (Victim) | 6GB | 4 cores | 60GB |
| Kali Linux (Attacker) | 2GB | 2 cores | 40GB |

---

## Network Configuration

All VMs use two adapters:
- **Adapter 1:** NAT (internet access for package downloads)
- **Adapter 2:** Host-Only — vboxnet0 (192.168.56.0/24 subnet, VM-to-VM communication)

| VM | Host-Only IP |
|---|---|
| Wazuh Server | 192.168.56.105 |
| Windows 11 Victim | 192.168.56.106 |
| Kali Attacker | 192.168.56.104 |

---

## Wazuh Installation

Installed using the official all-in-one script on Ubuntu Server 22.04:

```bash
curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh
sudo bash wazuh-install.sh -a
```

Dashboard accessible at: `https://192.168.56.105`

---

## Wazuh Agent — Windows 11

```powershell
Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.14.5-1.msi -OutFile $env:tmp\wazuh-agent.msi
msiexec.exe /i $env:tmp\wazuh-agent.msi /q WAZUH_MANAGER="192.168.56.105" WAZUH_AGENT_NAME="Windows11Victim"
NET START Wazuh
```

---

## Sysmon Installation — Windows 11

Using SwiftOnSecurity config for enriched endpoint logging:

```powershell
Invoke-WebRequest https://download.sysinternals.com/files/Sysmon.zip -OutFile $env:temp\Sysmon.zip
Expand-Archive $env:temp\Sysmon.zip -DestinationPath $env:temp\Sysmon -Force
Invoke-WebRequest https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml -OutFile $env:temp\sysmon.xml
& "$env:temp\Sysmon\Sysmon64.exe" -accepteula -i "$env:temp\sysmon.xml"
```

---

## Windows Logging Hardening

```powershell
# PowerShell Script Block Logging
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v EnableScriptBlockLogging /t REG_DWORD /d 1 /f

# Process Creation command line logging
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" /v ProcessCreationIncludeCmdLine_Enabled /t REG_DWORD /d 1 /f

# Audit process creation
auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable
```
