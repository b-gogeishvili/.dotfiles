#!/usr/bin/env bash

# Variables
enable_battery=false
battery_charging=false
battery_percentage=0

battery_empty=" "
battery_low=" "
battery_mid=" "
battery_good=" "
battery_full=" "

# Check availability
for battery in /sys/class/power_supply/*BAT*; do
  if [[ -f "$battery/uevent" ]]; then
    enable_battery=true
    if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
      battery_charging=true
    fi
    battery_percentage="$(cat /sys/class/power_supply/*/capacity | head -1)"
    break
  fi
done

# Output
if [[ $enable_battery == true ]]; then
  echo -n "$battery_percentage"%

  if [[ $battery_charging == true ]]; then
    echo -n " "
  else
    if [[ $battery_percentage -le 15 ]]; then
      echo -n "$battery_empty"
    elif [[ $battery_percentage -le 30 ]]; then
      echo -n "$battery_low"
    elif [[ $battery_percentage -le 60 ]]; then
      echo -n "$battery_mid"
    elif [[ $battery_percentage -le 90 ]]; then
      echo -n "$battery_good"
    else
      echo -n "$battery_full"
    fi
  fi

fi

echo ''