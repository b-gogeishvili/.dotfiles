#!/usr/bin/env bash

set -e

WALLS=($HOME/.dotfiles/assets/themes/wallpapers/*)
HYPR="$HOME/.dotfiles/.config/hypr"

refresh() {
    systemctl --user restart waybar
    systemctl --user restart hyprpaper
}

lockscreen() {
    local hyprlock="$HYPR/hyprlock.conf"
    local input="$1"

    sed -i "s@^\$background_image =.*@\$background_image = $input@g" "$hyprlock"
}

wallpaper() {
    local hyprpaper="$HYPR/hyprpaper.conf"
    local input="$1"

    sed -i "s@path =.*@path = $input@g" "$hyprpaper"
}


INPUT=$(gum choose ${WALLS[@]})

wallust -s run $INPUT
lockscreen $INPUT
wallpaper $INPUT

refresh
