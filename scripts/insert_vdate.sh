#!/bin/bash

# insert_vdate builds the template for my per-day diary in Vimwiki. It generates a title for the
# 'day' (you must pass the day as the $1, e.g. '2023-04-10') and a single checkbox list item. I have
# a binding in vimwiki that calls this script with the name of the file I have open (which is
# usually a per-day diary file such as '2023-04-10.wiki') and takes the output and pastes that into
# the current buffer. An example of the output is:
#
#     $ insert_vdate.sh '2023-04-10'
#     = Monday,    April     10th, 2023 =
#
#     - [ ]
#
# Note the odd spacing around the day and the month; that's done so that all the titles are of equal width in the auto-generated vimwiki diary page, looking like this:
#
#     = Diary =
#     == 2023 ==
#
#     === December ===
#         - [[2023-12-08|Friday,    December  08th, 2023]]
#         - [[2023-12-07|Thursday,  December  07th, 2023]]
#         - [[2023-12-06|Wednesday, December  06th, 2023]]
#         - [[2023-12-05|Tuesday,   December  05th, 2023]]
#         - [[2023-12-04|Monday,    December  04th, 2023]]

datestr="today"
if [[ -z "$1" ]]; then
	datestr="today"
else
	datestr="$1"
fi

# Pick out the date from paths to vimwiki diary files
if  echo "$datestr" | grep '\.wiki' > /dev/null; then
	datestr="${datestr##*/}"
	datestr="${datestr%.wiki}"
fi

printf "= %s =\n\n- [ ] " "$(~/dotfiles/scripts/vdate.sh "$datestr" )"
