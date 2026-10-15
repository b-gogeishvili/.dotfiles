#!/usr/bin/env bash
# ~/.config/sway/status.sh
# swaybar status line: layout | volume | brightness | battery | date
# Needs only swaymsg and wpctl (PipeWire/WirePlumber), both present on Fedora Sway.

SEP="  |  "

layout() {
  local name short
  name=$(swaymsg -t get_inputs 2>/dev/null \
    | grep -o '"xkb_active_layout_name": *"[^"]*"' | head -n1 | cut -d'"' -f4)
  [ -n "$name" ] || return
  short=${name:0:2}            # "English (US)" -> EN, "Georgian" -> GE
  printf 'KB %s' "${short^^}"
}

volume() {
  local out
  out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null) || return
  if [[ $out == *MUTED* ]]; then
    printf 'VOL muted'
  else
    awk '{ printf "VOL %d%%", $2 * 100 + 0.5 }' <<<"$out"
  fi
}

brightness() {
  local dev
  for dev in /sys/class/backlight/*; do
    [ -r "$dev/brightness" ] || continue
    printf 'BRI %d%%' $(( $(<"$dev/brightness") * 100 / $(<"$dev/max_brightness") ))
    return
  done
}

battery() {
  local bat cap state
  for bat in /sys/class/power_supply/BAT*; do
    [ -r "$bat/capacity" ] || continue
    cap=$(<"$bat/capacity")
    case $(<"$bat/status") in
      Charging) state=" +" ;;
      *)        state=""   ;;
    esac
    printf 'BAT %d%%%s' "$cap" "$state"
    return
  done
}

while :; do
  line=""
  for block in layout volume brightness battery; do
    s=$($block)
    [ -n "$s" ] && line+="${line:+$SEP}$s"
  done
  line+="${line:+$SEP}$(date +'%a %d %b  %H:%M')"
  printf '%s\n' "$line"
  sleep 1
done
