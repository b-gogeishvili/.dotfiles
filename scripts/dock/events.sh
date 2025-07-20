#!/bin/sh

# Listens to monitor events through Hyprland's socket

SCRIPT_PATH="/home/$USER/.dotfiles/.scripts/dock"

handle() {
  case $1 in
    monitoradded*) sh $SCRIPT_PATH/monitors.sh ;;
    monitorremoved*) sh $SCRIPT_PATH/monitors.sh ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
