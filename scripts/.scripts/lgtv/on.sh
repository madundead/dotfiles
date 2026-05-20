#!/bin/bash

tv_ip="192.168.0.249"
tv_mac="58:96:0A:61:1B:FC"

# Send Wake-on-LAN to power on the TV using multiple broadcast strategies and ports
# over a short duration to account for network interface initialization delays.
echo "Sending Wake-on-LAN to power on the TV ($tv_ip / $tv_mac)..."
for i in {1..15}; do
    # Subnet broadcast (Port 9 & 7)
    wakeonlan -i 192.168.0.255 -p 9 "$tv_mac"
    wakeonlan -i 192.168.0.255 -p 7 "$tv_mac"

    # Limited broadcast (Port 9 & 7)
    wakeonlan -i 255.255.255.255 -p 9 "$tv_mac"
    wakeonlan -i 255.255.255.255 -p 7 "$tv_mac"

    # Direct unicast (Port 9 & 7)
    wakeonlan -i "$tv_ip" -p 9 "$tv_mac"
    wakeonlan -i "$tv_ip" -p 7 "$tv_mac"

    sleep 1
done


