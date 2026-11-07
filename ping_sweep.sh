#!/bin/bash
# ping_sweep.sh - Basit ağ host keşif aracı (cross-platform ping sweep)
# Bir /24 ağdaki ayakta (up) olan host'ları ICMP ping ile bulur.
# Windows (Git Bash), Linux ve macOS'ta çalışır.
#
# Kullanım: ./ping_sweep.sh <network>
# Örnek:    ./ping_sweep.sh 192.168.1

if [ -z "$1" ]; then
    echo "Kullanım: $0 <network>"
    echo "Örnek:    $0 192.168.1"
    exit 1
fi

network=$1

# İşletim sistemine göre doğru ping flag'ini seç
case "$(uname -s)" in
    *NT*|*MINGW*|*MSYS*) PING="ping -n 1 -w 1000";;  # Windows (Git Bash)
    *)                   PING="ping -c 1 -W 1";;     # Linux / macOS
esac

echo "[*] $network.0/24 taranıyor..."

# 1-254 arası tüm host'ları paralel ping'le
for ip in $(seq 1 254); do
    ($PING "$network.$ip" &>/dev/null && echo "[+] $network.$ip UP") &
done

wait
echo "[*] Tarama tamamlandı."
