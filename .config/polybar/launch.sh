#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done
# gather screen resolution information
screenres=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')

if [ $screenres == '2560x1440' ] ; then
	# Launch the triple bar
	polybar left &
	polybar center &
	polybar right &
else
	polybar mono &
fi
