#!/bin/bash

chosen=$(nmcli --fields SSID,SIGNAL device wifi list | sed 'id' | rofi -dmenu -p "WiFi")

if [ -n "$chosen" ]; then
	ssid=$(echo "$chosen" | awk '{print $1}')
	nmcli device wifi connect "$ssid"
fi
