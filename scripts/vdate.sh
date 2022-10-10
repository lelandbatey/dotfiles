#!/bin/bash

usage () {
    PROGNAME="$(basename "$0")"
    echo "Usage: $(basename $0) [CURRENTDATE]"
    echo "Prints the current date in a human readable, but fixed-width, format."
    echo "CURRENTDATE is a string expressing a date; if provided then the the date"
    echo "printed will be the moment described in CURRENTDATE, not 'now'. CURRENTDATE"
    echo "must be a string compatible with the '--date' option of the 'date' command from"
    echo "GNU coreutils."
    echo ''
    echo 'Examples:'
    echo 'Print the fixed-width date for right now:'
    echo "    $ ${PROGNAME}"
    echo ''
    echo 'Print the fixed-width date for yesterday:'
    echo "    $ ${PROGNAME} 'yesterday'"
    echo ''
    echo 'Print the fixed-width date for Monday, December 11th, 2017:'
    echo "    $ ${PROGNAME} '2017-12-11 09:08:07'"
    echo ''
    echo 'Print the fixed-width date for Monday, December 11th, 2017 but specified using'
    echo 'a UNIX Epoch timestamp (seconds since the epoch (1970-01-01 UTC)):'
    echo "    $ ${PROGNAME} '@1513012087'"
    exit 1
}

DaySuffix() {
    case `date +%d` in
        01|21|31) echo "st";;
        02|22)    echo "nd";;
        03|23)    echo "rd";;
        *)       echo "th";;
    esac
}

if echo "$1" | grep -i '\-h' > /dev/null; then
    usage
fi

if [[ -z "$1" ]]; then
    NOW_EPOCH="$(date "+%s")"
else
    NOW_EPOCH="$(date "+%s" --date="$1")"
fi


# We pad our Day and Month so that the output is always a constant width. Since
# day name has a comma after, we have to add one to their width in the final
# padding formatter.
# 'Wednesday' is longest day-of-week name at 9
# 'September' is longest month name at 9
# Since the date(1) command doesn't allow specifying left-justification when
# padding, we must use printf for the padding
printf "%-10s %-9s %s %s" $(date --date="@${NOW_EPOCH}" "+%A, %B %d$(DaySuffix), %Y")
