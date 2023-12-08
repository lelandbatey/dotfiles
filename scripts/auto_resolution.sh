#!/bin/bash

# Finds the currently "preferred resolution" for the screen named 'Virtual-1'
# and sets that resolution as the current resolution. This is only really
# applicable when running Linux inside of parallels, as that's the only time
# these outputs have these names.
#
# Useful because when I resize the window containing the VM, the VM (with
# Parallels Tools installed) notices and changes the 'preferred' resolution.
# However, i3 doesn't automatically change the actual resolution to match the
# preferred resolution. So this script can be quickly run manually in order to
# switch it after a resize.

PREFERRED_RESOLUTION="$(xrandr -q | awk '/^Virtual-1 /{flag=1;next}/Virtual-2 /{flag=0}flag' | grep -E '\W\+$' | awk '{print $1}')"


xrandr --output Virtual-1 --primary --mode "${PREFERRED_RESOLUTION}" \
	--pos 0x0 --rotate normal \
	--output Virtual-2 --off \
	--output Virtual-3 --off \
	--output Virtual-4 --off \
	--output Virtual-5 --off \
	--output Virtual-6 --off \
	--output Virtual-7 --off \
	--output Virtual-8 --off \
	--output Virtual-9 --off \
	--output Virtual-10 --off \
	--output Virtual-11 --off \
	--output Virtual-12 --off \
	--output Virtual-13 --off \
	--output Virtual-14 --off \
	--output Virtual-15 --off \
	--output Virtual-16 --off

