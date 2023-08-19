#!/bin/bash

# Calendar script

function ShowCalendar() {
	notify-send -i "calendar"  "    📅 Calendar" "$(cal --color=always | sed "s/..7m/<b><span color=\"#fabd2f\">/;s/..0m/<\/span><\/b>/")" -r 124
}

function EditCalendar() {
  echo 
}

case "$1" in
        show)
            ShowCalendar
            ;;
         
        edit)
            EditCalendar
            ;;
         
        *)
            echo $"Usage: ${0##*/} {show|edit}"
            exit 1
 
esac
