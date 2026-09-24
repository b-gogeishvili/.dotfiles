#!/usr/bin/env bash

fullscreen() {
  # Continuously checking the cursor position and toggling the bar accordingly
  case "$(hyprctl activeworkspace -j)" in
    *'"hasfullscreen": false'*)
      kill "$PEEK" 2>/dev/null
      # Show Waybar
      pkill -SIGUSR1 waybar ;;
    *)
      kill "$PEEK" 2>/dev/null
      # Hide Waybar
      pkill -SIGUSR2 waybar

      while true; do
        Y_POS=$(hyprctl cursorpos | awk -F, '{print $2}' | tr -d ' ')

        # Check if mouse is at the top edge
        if [ "$Y_POS" -eq 0 ]; then
          pkill -SIGUSR1 waybar

          # This inner loop runs *only* while the mouse is on the bar.
          # It traps the script, keeping the bar open.
          while [ "$Y_POS" -le 48 ]; do
            sleep 0.2
            Y_POS=$(hyprctl cursorpos | awk -F',' '{print $2}' | tr -d ' ')
          done

          # Hide the bar when cursor leaves the bar (set to size 48).
          pkill -SIGUSR2 waybar
        fi
        sleep 0.2
      done &
      PEEK=$!
  esac  
}

handle() {
  case $1 in
    fullscreen'>>'*|workspace'>>'*|focusedmon'>>'*) fullscreen ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
