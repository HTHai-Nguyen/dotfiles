#!/bin/bash
choice=$(printf "Shutdown\nReboot\nLogout\nSleep\nLock" |
  fuzzel --dmenu --prompt="Power Menu:")

case "$choice" in
"Shutdown")
  systemctl poweroff
  ;;
"Reboot")
  systemctl reboot
  ;;
"Sleep")
  systemctl suspend
  ;;
"Lock")
  loginctl lock-session
  ;;
"Logout")
  swaymsg exit
  ;;
esac
