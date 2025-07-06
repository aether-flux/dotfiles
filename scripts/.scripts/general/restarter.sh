#!/bin/bash

component=$(printf "%s\n" \
  "dunst" \
  "tmux" \
  "waybar" \
  "hyprland" | rofi -dmenu -i -p "Restart..." -theme ~/.config/rofi/launchers/project/restart.rasi)

case $component in
  "dunst")
    pkill dunst && dunst & ;;
  "tmux")
    tmux source-file ~/.tmux.conf ;;
  "waybar")
    pkill waybar && waybar & ;;
  "hyprland")
    hyprctl reload ;;
esac

