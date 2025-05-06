#! /bin/bash

# Disables or enables laptop screen accordingly

num_monitors=$(hyprctl monitors all | grep Monitor | wc -l)

if [ "$num_monitors" -eq 3 ]; then
    hyprctl keyword monitor "eDP-1,disable"
    hyprctl keyword monitor "DP-4,2560x1440@100,0x0,1,bitdepth,10"
    hyprctl keyword monitor "DP-5,1920x1080@100,-1080x-360,1,transform,1,bitdepth,10"

    hyprctl dispatch moveworkspacetomonitor 1 DP-5
    hyprctl dispatch moveworkspacetomonitor 4 DP-5

    hyprctl dispatch moveworkspacetomonitor 2 DP-4
    hyprctl dispatch moveworkspacetomonitor 3 DP-4
else
    hyprctl keyword monitor "eDP-1,1920x1200@60,0x0,1,bitdepth,10"
fi

hyprctl dispatch workspace 1

sleep 1
# systemctl --user restart waybar
