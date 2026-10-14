#!/bin/sh

# Autostart script for Qtile
autorandr --change &
feh &

# Authentication dialog
# pkill -f /usr/libexec/polkit-gnome-authentication-agent-1
# /usr/libexec/polkit-gnome-authentication-agent-1 &

# Kill any existing pipewire / wireplumber daemons and only then try to start a new set.
# pkill -u "${USER}" -x pipewire\|wireplumber 1>/dev/null 2>&1
# dbus-run-session pipewire &> /dev/null &

# Network Manager applet
# pkill nm-applet 2>/dev/null
nm-applet &

# Kanshi
# pkill -f kanshi
# kanshi &

# Notification daemon
pkill -f dunst
dunst &

# Start xdg-desktop-portal-wlr  
# pkill -f /usr/libexec/xdg-desktop-portal-wlr
# /usr/libexec/xdg-desktop-portal-wlr &

# wlsunset
# pkill -f wlsunset
# wlsunset -l 57.4 -L -1.9 &

# Swayidle daemon
# pkill -f swayidle
# swayidle \
# 	timeout 5 'qtile cmd-obj -o core -f hide_cursor' resume 'qtile cmd-obj -o core -f unhide_cursor' \
# 	timeout 300 'swaylock -f -i $wallpaper' \
# 	timeout 600 'wlopm --off \*' resume 'wlopm --on \*' &

