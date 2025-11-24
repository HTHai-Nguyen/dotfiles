#!/bin/bash

wifi_list=$(nmcli -t -f SSID,SECURITY device wifi list | sed 's/:/ 🔒 /')

selected=$(echo "$wifi_list" |
  wofi --dmenu \
    --location=top_right \
    --width=300 --prompt "Choose Wi-Fi:")

[ -z "$selected" ] && exit

ssid=$(echo "$selected" | cut -d " " -f 1)

if echo "$selected" | grep -q "🔒"; then
  pass=$(
    wofi --dmenu \
      --password \
      --location=top_right \
      --width=300 --height=0 --prompt "Password:"
  )
  nmcli device wifi connect "$ssid" password "$pass"
else
  nmcli device wifi connect "$ssid"
fi
