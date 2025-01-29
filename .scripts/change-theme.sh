#!/usr/bin/env bash

# Replace Wallpaper
wallpaper () {
    read -p "Wallpaper name => " USER_INPUT

    hyprpaper="/home/$USER/workspace/personal/temp/hyprpaper.conf"

    for pattern in preload wallpaper; do
        find="^$pattern =.*"
        replace="$pattern = /home/$USER/.dotfiles/assets/wallpapers/$USER_INPUT"
        sed -i "s@$find@$replace@g" $hyprpaper
    done

    systemctl --user restart hyprpaper.service
}

wallpaper