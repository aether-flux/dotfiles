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
        -e "s|{{DUNST_NORMAL_FG}}|${bg}|g" \
        -e "s|{{DUNST_CRITICAL_FG}}|${fg_crit}|g" \
        -e "s|{{BORDER_RADIUS}}|${borrad/2}|g" \
        "$template" > "$output"

    pkill dunst; dunst &
}

apply_dunst_theme
