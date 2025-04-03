#!/usr/bin/env bash

dock() {
  find='^monitor = eDP-1.*'
  replace='monitor = eDP-1, disable'

  sed -i "s/$find/$replace/g" /home/besik/.dotfiles/.config/hypr/hyprland.conf
}

undock() {
  find='^monitor = eDP-1.*'
  replace='monitor = eDP-1, 1920x1200@60, 0x0, 1, bitdepth, 10'

  sed -i "s/$find/$replace/g" /home/besik/.dotfiles/.config/hypr/hyprland.conf
}

handle() {
  case $1 in
    monitoradded*) dock ;;
    monitorremoved*) undock ;;
  esac
}

if [[ "$1" == "startup" ]]; then
  output=$(hyprctl monitors)

  if echo "$output" | grep -q "DP-4"; then
    dock
  else
    undock
  fi
else
  socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
fi
