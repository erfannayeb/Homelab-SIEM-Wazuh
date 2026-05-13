# powershell-execution.ps1
# Attack Simulation: Suspicious PowerShell Execution
# MITRE ATT&CK: T1059.001
# WARNING: For homelab use only — run on Windows 11 Victim VM

Write-Host "[*] Simulating suspicious PowerShell activity..."

# Encoded command execution (decodes to: ipconfig)
Write-Host "`n[1] Encoded command execution:"
powershell -EncodedCommand aQBwAGMAbwBuAGYAaQBnAA==

# System reconnaissance
Write-Host "`n[2] Local user enumeration:"
Get-LocalUser

Write-Host "`n[3] Administrators group members:"
Get-LocalGroupMember Administrators

Write-Host "`n[4] Active network connections:"
netstat -ano

Write-Host "`n[*] Done — check Wazuh for rule 91801 alerts"
