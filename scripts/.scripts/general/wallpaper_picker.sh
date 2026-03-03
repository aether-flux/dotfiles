#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
STATE_FILE="$HOME/.config/themes/current/.current_wallpaper"

mkdir -p "$THUMB_DIR"

# Generate thumbnails
find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r wall; do
    thumb="$THUMB_DIR/$(basename "$wall").thumb.png"
    if [ ! -f "$thumb" ]; then
        convert "$wall" -thumbnail 256x144^ -gravity center -extent 256x144 "$thumb"
    fi
done

TMPFILE=$(mktemp)

find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r wall; do
    thumb="$THUMB_DIR/$(basename "$wall").thumb.png"
    name=$(basename "$wall")
    echo "$name"$'\0''icon'$'\x1f'"$thumb"
    echo "$wall" >> "$TMPFILE"
done | {
    # Pair names+icons with paths
    names=()
    paths=()
    while IFS= read -r line; do
        names+=("$line")
    done
    # can't easily pair in a pipe, use the approach below instead
}

mapfile -t WALLS < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)

ROFI_INPUT=""
for wall in "${WALLS[@]}"; do
    thumb="$THUMB_DIR/$(basename "$wall").thumb.png"
    name=$(basename "$wall")
    ROFI_INPUT+="$name"$'\0'''$''""$'\n'
done


SELECTED_NAME=$(echo -e "$ROFI_INPUT" | rofi -dmenu -i \
    -theme "$HOME/.config/rofi/appLauncher/project/base.rasi" \
    -theme-str '* { placeholder-text: "Select Wallpaper..."; }' \
    -theme-str 'element-icon { size: 128px; margin: 0 10px 0 0; }' \
    -theme-str 'element { padding: 8px; border-radius: 8px; children: [element-icon, element-text]; }' \
    -theme-str 'window { width: 600px; height: 600px; }' \
    -theme-str 'listview { lines: 4; columns: 1; spacing: 6px; }' \
    -p "Wallpaper")

if [ -n "$SELECTED_NAME" ]; then
    SELECTED_PATH=""
    for wall in "${WALLS[@]}"; do
        if [ "$(basename "$wall")" = "$SELECTED_NAME" ]; then
            SELECTED_PATH="$wall"
            break
        fi
    done

    if [ -n "$SELECTED_PATH" ]; then
        awww img $SELECTED_PATH --transition-type wave --transition-angle 45 --transition-bezier .31,.08,.3,.99 --transition-duration 2 &
        echo "$SELECTED_PATH" > "$STATE_FILE"
    fi
fi

