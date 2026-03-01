#!/bin/bash

component=$(printf "%s\n" \
  "dunst" \
  "tmux" \
  "waybar" \
  "hyprland" | rofi -dmenu \
     -theme ~/.config/rofi/appLauncher/project/base.rasi \
     -theme-str '* { placeholder-text: "Restart..."; }')

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

