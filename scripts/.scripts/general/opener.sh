#!/bin/bash

component=$(printf "%s\n" \
  "btop" \
  "Pipes" \
  "NeoFetch" \
  "FastFetch" | rofi -dmenu -i -p "Run command" -theme ~/.config/rofi/launchers/project/opener.rasi)

case $component in
  "btop")
    kitty -e sh -c btop ;;
  "NeoFetch")
    kitty -e sh -c "neofetch; echo; echo Press any key to exit...; read -n 1" ;;
  "FastFetch")
    kitty -e sh -c "fastfetch; echo; echo Press any key to exit...; read -n 1" ;;
  "Pipes")
    kitty -e sh -c pipes.sh ;;
esac

