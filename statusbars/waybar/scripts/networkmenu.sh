#!/bin/bash

wifi_list=$(nmcli -t -f SSID dev wifi)

choosen=$(echo "$wifi_list" | fuzzel --dmenu --prompt "Connect to Wi-Fi:")

if [ -n "$choosen" ]; then
  nmcli dev wifi connect "$choosen"
fi
