#!/usr/bin/env bash

# 1. Replace Wallpaper and Lockscreen

hyprpaper="/home/$USER/.dotfiles/temp.txt"

new_lines=$(cat <<EOF
New Line 1
New Line 2
New Line 3
EOF
)

sed -i "1,3c$new_lines" "$hyprpaper"
