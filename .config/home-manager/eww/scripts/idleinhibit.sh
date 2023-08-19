#!/bin/bash

# Swayidle toggle
function toggle {
	if pgrep "swayidle" > /dev/null
	then
		pkill swayidle
		notify-send -r 5556 -u normal "  Swayidle Inactive"
	else
		swayidle timeout 300 'swaylock -F -i ~/.cache/wallpaper --effect-blur 10x5 --clock --indicator' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' &
		notify-send -r 5556 -u normal "  Swayidle Active"
	fi
}

case $1 in
	toggle)
		toggle
		;;
	*)
		if pgrep "swayidle" > /dev/null
		then
			icon=""
		else
			icon=""
		fi
		printf "%s" "$icon "
		;;
esac

