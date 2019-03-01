#!/bin/sh
MODENAME="1600x900"
MODE_EXISTS="$(xrandr | ag "$MODENAME")"
if [ -z "$MODE_EXISTS" ]; then
    echo "Adding a new mode: $MODENAME"
    xrandr --newmode "1600x900"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
    xrandr --addmode eDP-1 1600x900
fi

#xrandr --verbose --output eDP-1 --mode 1600x900 --pos 0x592 --rotate normal --output DP-1-1 --off --output HDMI-2 --off --output HDMI-1 --off --output DP-1-8 --primary --mode 2560x1440 --pos 1600x0 --rotate normal --output DP-2 --off --output DP-1 --off
xrandr --verbose --output eDP-1 --mode 1600x900 --pos 0x592 --rotate normal --output DP-1-1 --off --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --primary --mode 2560x1440 --pos 1600x0 --rotate normal --output DP-2 --off
#xrandr --verbose --output DP-1-8 --primary --mode 2560x1440 --pos 1600x0 --rotate normal
