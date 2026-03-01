#!/bin/bash

component=$(printf "%s\n" \
  "btop" \
  "Pipes" \
  "NeoFetch" \
  "FastFetch" | rofi -dmenu \
     -theme ~/.config/rofi/appLauncher/project/base.rasi \
     -theme-str '* { placeholder-text: "Programs..."; }')

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

