#!/bin/bash

if dunstctl is-paused | grep -q "true"; then
    echo '{"text": "", "tooltip": "DND enabled", "class": "dnd-on"}'
else
    echo '{"text": "", "tooltip": "DND disabled", "class": "dnd-off"}'
fi

