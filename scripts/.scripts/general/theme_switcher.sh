#!/bin/bash

apply_dunst_theme() {
    local theme_dir="$HOME/.config/themes/current"
    local template="$HOME/.config/dunst/dunstrc.template"
    local output="$HOME/.config/dunst/dunstrc"
    local kitty="$theme_dir/kitty.conf"

    get_color() {
        grep -P "^${1}\s+" "$kitty" | grep -v "^#" | awk '{print $2}' | tail -1
    }

    local bg="$(get_color background)"
    local fg="$(get_color foreground)"
    local green="$(get_color color2)"
    local accent="$(get_color cursor)"
    local red="$(get_color color1)"
    local fg_crit="$(get_color color15)"
    local fg_normal="$(get_color color7)"

    # Border radius from colors.conf
    eval "$(sed -n 's/^\$\([a-zA-Z_][a-zA-Z_0-9]*\)\s*=\s*\(.*\)/\1="\2"/p' \
        "$theme_dir/colors.conf")"

    sed \
        -e "s|{{DUNST_FRAME}}|${bg}|g" \
        -e "s|{{DUNST_LOW_BG}}|${bg}cc|g" \
        -e "s|{{DUNST_NORMAL_BG}}|${accent}cc|g" \
        -e "s|{{DUNST_CRITICAL_BG}}|${red}cc|g" \
        -e "s|{{DUNST_CRITICAL_FRAME}}|${red}|g" \
        -e "s|{{DUNST_LOW_FG}}|${fg}|g" \
        -e "s|{{DUNST_NORMAL_FG}}|${bg}88|g" \
        -e "s|{{DUNST_CRITICAL_FG}}|${fg_crit}|g" \
        -e "s|{{BORDER_RADIUS}}|${borrad/2}|g" \
        "$template" > "$output"

    pkill dunst; dunst &
}

choice=$(printf "%s\n" \
  "Everforest" \
  "Jade Night" \
  "Nord" \
  "Gruvbox" \
  "E-Ink" \
  "Scarlet" \
  "Themename" \
  "Catppuccin" | rofi -dmenu \
     -theme ~/.config/rofi/appLauncher/project/base.rasi \
     -theme-str '* { placeholder-text: "Select Theme..."; }')

case $choice in
  "Everforest")
    cp -r $HOME/.config/themes/everforest/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/ever_1 --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Jade Night")
    cp -r $HOME/.config/themes/jade_night/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/jade_night_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Nord")
    cp -r $HOME/.config/themes/nord/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/nord_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Gruvbox")
    cp -r $HOME/.config/themes/gruvbox/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/gruvbox_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "E-Ink")
    cp -r $HOME/.config/themes/eink/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/eink_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Scarlet")
    cp -r $HOME/.config/themes/scarlet/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/scarlet_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Horizon")
    cp -r $HOME/.config/themes/horizon/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/horizon_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
  "Catppuccin")
    cp -r $HOME/.config/themes/catppuccin/* $HOME/.config/themes/current/
    apply_dunst_theme
    dunstify "Switching theme: $choice"
    awww img $HOME/Pictures/Wallpapers/catppuccin_1.jpg --transition-type center --transition-bezier .31,.08,.3,.99 --transition-duration 2 & disown
    paplay ~/Documents/Sounds/theme_switch.mp3 --volume=32768 &
    hyprctl reload
    killall waybar
    waybar & disown
    ;;
esac

