# ping-sweep

Basit bir ağ host keşif (host discovery) aracı. Bir `/24` ağdaki ayakta olan
cihazları ICMP ping ile bulur. Saf Bash ile yazılmıştır, bağımlılığı yoktur.

## Kullanım

```bash
chmod +x ping_sweep.sh
./ping_sweep.sh <network>
```

Örnek:

```bash
./ping_sweep.sh 192.168.1
```

Çıktı:

```
[*] 192.168.1.0/24 taranıyor...
[+] 192.168.1.1 UP
[+] 192.168.1.37 UP
[+] 192.168.1.42 UP
[*] Tarama tamamlandı.
```

## Nasıl çalışır

- `1`-`254` arası tüm host adreslerini döngüyle gezer
- Her adrese `ping -c 1 -W 1` ile tek bir ICMP paketi yollar (max 1 sn bekler)
- Ping cevap verirse host "UP" olarak listelenir
- Ping'ler arka planda (`&`) paralel çalışır, `wait` ile hepsi beklenir → hızlı

## Notlar

- ICMP tabanlıdır: ping'i bloklayan (firewall) host'lar "UP" görünmeyebilir.
- Sadece yetkili olduğun ağlarda kullan.

## Lisans

MIT
