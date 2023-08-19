#!/bin/bash

# Get long name
# echo "$(hyprctl devices | grep -A 2 "at-translated-set-2-keyboard" | awk 'NR==3 {print $3" "$4}')"

# Get short name
echo "$(hyprctl devices | grep -A 2 "at-translated-set-2-keyboard" | awk 'NR==3 {print $4}'| grep -Po '(?<=\().*(?=\))' )"

