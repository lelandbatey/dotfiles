#!/bin/sh
#xrandr --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --mode 3840x2160 --pos 2560x0 --rotate normal --output HDMI-0 --off --output eDP-1-1 --primary --mode 2560x1600 --pos 0x560 --rotate normal

# Since we know which display is the laptop display, search for 1 other connected display, assume
# that's the one we're using, assume it's got a 4k resolution, position it to the right of the
# laptop display, then move all the workspaces (except 9 and 10) onto the big screen

LAPTOP_DISPLAY="eDP-1-1"
SECOND_DISPLAY="$(xrandr --query | grep ' connected' | grep -v "$LAPTOP_DISPLAY" | awk '{print $1}')"

xrandr \
	--output "$SECOND_DISPLAY"           --mode 3840x2160 --pos 2560x0  --rotate normal \
	--output "$LAPTOP_DISPLAY" --primary --mode 2560x1600 --pos 0x0     --rotate normal


i3-msg "workspace 1,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 2,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 3,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 4,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 5,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 6,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 7,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 8,  move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 12, move workspace to output $SECOND_DISPLAY"
i3-msg "workspace 1,  move workspace to output $SECOND_DISPLAY"
