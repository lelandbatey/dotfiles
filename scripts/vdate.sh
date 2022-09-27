#!/bin/bash

DaySuffix() {
  case `date +%d` in
    01|21|31) echo "st";;
    02|22)    echo "nd";;
    03|23)    echo "rd";;
    *)       echo "th";;
  esac
}

# We pad our Day and Month so that the output is always a constant width. Since
# day name has a comma after, we have to add one to their width in the final
# padding formatter.
# 'Wednesday' is longest day-of-week name at 9
# 'September' is longest month name at 9
# Since the date(1) command doesn't allow specifying left-justification when
# padding, we must use printf for the padding
printf "%-10s %-9s %s %s" $(date "+%A, %B %d$(DaySuffix), %Y")
