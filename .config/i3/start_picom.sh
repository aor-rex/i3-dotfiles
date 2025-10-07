#!/bin/bash
# toggle picom on/off

compositor="picom"

if pgrep -x "$compositor" >/dev/null; then
    # Picom is running → stop it
    pkill -x "$compositor"
else
    # Picom not running → start it with your options
    "$compositor" \
        --corner-radius 18 \
        --active-opacity 0.95 \
        --inactive-opacity 0.90 \
        --blur-method dual_kawase \
        --blur-strength 12 \
        --shadow \
        --shadow-exclude "(class_g = 'Polybar' || name = 'polybar')" \
        --rounded-corners-exclude "(class_g = 'Polybar' || name = 'polybar')" &>/dev/null &
fi
