#!/bin/bash

choice=$(printf "%s\n" \
  "Everforest" \
  "Jade Night" \
  "Nord" \
  "Gruvbox" \
  "E-Ink" \
  "Scarlet" \
  "Catppuccin" | rofi -dmenu \
     -theme ~/.config/rofi/appLauncher/project/base.rasi \
     -theme-str '* { placeholder-text: "Select Theme..."; }')

case $choice in
  "Everforest")
    cp -r $HOME/.config/themes/everforest/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/ever_1 --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Jade Night")
    cp -r $HOME/.config/themes/jade_night/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/jade_night_1.jpg --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Nord")
    cp -r $HOME/.config/themes/nord/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/nord_1.jpg --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Gruvbox")
    cp -r $HOME/.config/themes/gruvbox/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/gruvbox_1.jpg --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "E-Ink")
    cp -r $HOME/.config/themes/eink/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/eink_1.jpg --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Scarlet")
    cp -r $HOME/.config/themes/scarlet/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/scarlet_1.jpg --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Catppuccin")
    cp -r $HOME/.config/themes/catppuccin/* $HOME/.config/themes/current/
    awww img $HOME/Pictures/Wallpapers/catppuccin_1.jpg --transition-type random & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
esac


