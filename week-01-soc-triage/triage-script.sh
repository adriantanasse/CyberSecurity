#!/bin/bash
# triage-script.sh — quick host artifact collector (lab use only)
# Usage: sudo ./triage-script.sh
OUT=/tmp/triage-$(date +%Y%m%d-%H%M%S)
mkdir -p $OUT
uname -a > $OUT/uname.txt
ps aux --sort=-%mem | head -n 50 > $OUT/processes.txt
ss -tunap > $OUT/sockets.txt
sudo lsof -nP > $OUT/lsof.txt
last -n 50 > $OUT/lastlogins.txt
sudo journalctl -n 200 > $OUT/journalctl.last200.txt 2>/dev/null || true
sudo cat /var/log/auth.log > $OUT/auth.log 2>/dev/null || true
sudo md5sum $OUT/* > $OUT/md5sums.txt
tar -czf ${OUT}.tar.gz -C /tmp $(basename $OUT)
echo "Triage done: ${OUT}.tar.gz"
