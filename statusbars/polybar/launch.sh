#!/bin/bash

killall -q polybar

#polybar left &
#polybar right &
#polybar middle &
#polybar tray &
#polybar xwindow &

echo "---" | tee -a /tmp/polybar1.log
polybar bar1 2>&1 | tee -a /tmp/polybar1.log &
disown

