#!/bin/sh

function handle {
  if [[ ${1:0:12} == "monitoradded" ]]; then
    ~/.config/eww/scripts/start.sh
  elif [[ ${1:0:14} == "monitorremoved" ]]; then
    ~/.config/eww/scripts/start.sh
  fi
}

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
