#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Screen resolution. Currently report 2560x1440, so we'd see 1920x1080 for that monitor.
# xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/'

# Launch
polybar left &
polybar center &
polybar right &
