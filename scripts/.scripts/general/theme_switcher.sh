#!/bin/bash

# choice=$(printf "%s\n" \
#   "Everforest" \
#   "Nord" \
#   "Gruvbox" \
#   "Catppuccin" | rofi -dmenu -i -p "Switch Theme" -theme ~/.config/rofi/launchers/project/theme_switcher.rasi)

choice=$(printf "%s\n" \
  "Everforest" \
  "Nord" \
  "Gruvbox" \
  "Scarlet" \
  "Catppuccin" | rofi -dmenu \
     -theme ~/.config/rofi/appLauncher/project/base.rasi \
     -theme-str '* { placeholder-text: "Select Theme..."; }')

# rofi -show drun \
#      -theme ~/.config/rofi/base.rasi \
#      -theme-str '* { placeholder-text: "Select Theme..."; }'

case $choice in
  "Everforest")
    cp -r $HOME/.config/themes/everforest/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/ever_1 --transition-type random & disown
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Nord")
    cp -r $HOME/.config/themes/nord/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/nord_1.jpg --transition-type random & disown
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Gruvbox")
    cp -r $HOME/.config/themes/gruvbox/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/gruvbox_1.jpg --transition-type random & disown
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Catppuccin")
    cp -r $HOME/.config/themes/catppuccin/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/catppuccin_1.jpg --transition-type random & disown
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Scarlet")
    cp -r $HOME/.config/themes/scarlet/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/scarlet_1.jpg --transition-type random & disown
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
esac


