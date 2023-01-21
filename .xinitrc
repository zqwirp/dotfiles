#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

session=${1:-dwm}

case $session in
	dwm)
		# Start the loop
		while true; do
			SLEEP=15 # Suspend time

			# Date
			DATE=$(/usr/bin/date +"%a, %B %d | %H:%M")

			# Battery
			if [ -d /sys/class/power_supply/BAT0 ]; then
				BATTERY_STATUS=$(/usr/bin/cat /sys/class/power_supply/BAT0/status)
				BATTERY_CAPACITY=$(/usr/bin/cat /sys/class/power_supply/BAT0/capacity)
				BATTERY="$BATTERY_STATUS $BATTERY_CAPACITY"
			else
				BATTERY="N/A"
			fi

			# Memory
			MEMORY=$(free -m | awk 'NR%2==0 {print $3}')

			# Execute xsetroot
			xsetroot -name "${MEMORY}Mb | ${BATTERY}% | $DATE"

			sleep $SLEEP # Suspend
		done &

		exec dwm
		;;
	xfce)
		exec startxfce4
		;;
	gnome)
		export XDG_SESSION_TYPE=x11
		export GDK_BACKEND=x11

		exec gnome-session

		;;
		# No known session, try to run it as command
		*)
		exec $1
		;;
esac
