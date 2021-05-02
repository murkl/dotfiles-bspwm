#!/bin/sh
#source $HOME/.config/ecos/ecos.conf

# Terminate already running bar instances.
killall -q polybar

# Wait until the processes have been shutdown.
while pgrep -x polybar >/dev/null; do sleep 1; done

for i in $(polybar -m | awk -F: '{print $1}'); do MONITOR=$i polybar mainbar 2> /tmp/polybar.log & done

echo "Bars launched..."
