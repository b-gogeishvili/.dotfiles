#!/bin/env bash

# Listens to monitor events through Hyprland's socket

INTERNAL=eDP-1
last_state=""

# Names of connected outputs that aren't the laptop panel.
#
# Counting monitors does not work here: a disabled output stays listed, and
# Hyprland synthesises a "FALLBACK" output whenever nothing real is enabled.
# Undocked with the panel off, both are present and any count-based check
# concludes "still docked", re-disables the panel and deadlocks on a black
# screen. Disconnected outputs do leave the list, so ask by name instead.
externalMonitors() {
    hyprctl monitors all -j |
        jq -r --arg internal "$INTERNAL" \
            '.[].name | select(. != $internal and . != "FALLBACK")'
}

monitorsChanged() {
    # Disables or enables laptop screen accordingly

    if [ -n "$(externalMonitors)" ]; then
        state=docked
    else
        state=undocked
    fi

    # The hyprctl calls below emit their own monitoradded/monitorremoved
    # events, which come back through this same socket. Only act on real
    # transitions so we don't modeset in a loop.
    [ "$state" = "$last_state" ] && return
    last_state=$state

    if [ "$state" = docked ]; then
        # Enable the external before disabling the panel, so the session is
        # never left with zero outputs (which is what summons FALLBACK).
        hyprctl keyword monitor "DP-4,2560x1440@100,0x0,1,bitdepth,10"
        hyprctl keyword monitor "$INTERNAL,disable"
        # hyprctl keyword monitor "DP-5,1920x1080@100,-1080x-360,1,transform,1,bitdepth,10"
    else
        hyprctl keyword monitor "$INTERNAL,1920x1200@60,0x0,1,bitdepth,10"
    fi

    hyprctl dispatch workspace 1

    sleep 1

    # Last resort: if we somehow ended up with nothing to draw on, get the
    # panel back rather than leaving an unrecoverable black screen.
    if [ -z "$(hyprctl monitors -j | jq -r '.[].name' | grep -v FALLBACK)" ]; then
        hyprctl keyword monitor "$INTERNAL,preferred,0x0,1"
        last_state=undocked
    fi
}

handle() {
  # The '>>' anchors these so they don't also match monitoraddedv2 /
  # monitorremovedv2, which Hyprland emits alongside every hotplug.
  case $1 in
    monitoradded'>>'*) monitorsChanged ;;
    monitorremoved'>>'*) monitorsChanged ;;
  esac
}

# Sync once at startup: without this, last_state stays empty and the panel
# keeps whatever state it was left in until the next hotplug.
monitorsChanged

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
