#!/bin/bash
# smb-enumeration.sh
# Attack Simulation: SMB Enumeration
# MITRE ATT&CK: T1135
# WARNING: For homelab use only — run on Kali Attacker VM

TARGET="192.168.56.106"

echo "[*] Starting SMB enumeration against $TARGET"
echo ""

# Anonymous SMB access attempt
echo "[1] Attempting anonymous SMB access..."
smbclient -L //$TARGET -N
echo ""

# Full enum4linux enumeration
echo "[2] Running enum4linux..."
enum4linux -a $TARGET
echo ""

# Nmap SMB scripts
echo "[3] Nmap SMB vulnerability scan..."
nmap --script smb-vuln-ms17-010 $TARGET
echo ""

echo "[4] Nmap SMB share enumeration..."
nmap --script smb-enum-shares $TARGET

echo ""
echo "[*] Done — check Wazuh for SMB-related alerts"
