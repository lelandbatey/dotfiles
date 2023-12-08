#!/bin/bash

# Trying to print the following:

#   February 2022            May 2022            August 2022          November 2022
#Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
#       1  2  3  4  5   1  2  3  4  5  6  7      1  2  3  4  5  6         1  2  3  4  5
# 6  7  8  9 10 11 12   8  9 10 11 12 13 14   7  8  9 10 11 12 13   6  7  8  9 10 11 12
#13 14 15 16 17 18 19  15 16 17 18 19 20 21  14 15 16 17 18 19 20  13 14 15 16 17 18 19
#20 21 22 23 24 25 26  22 23 24 25 26 27 28  21 22 23 24 25 26 27  20 21 22 23 24 25 26
#27 28                 29 30 31              28 29 30 31           27 28 29 30
#
#     March 2022            June 2022           September 2022        December 2022
#Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
#       1  2  3  4  5            1  2  3  4               1  2  3               1  2  3
# 6  7  8  9 10 11 12   5  6  7  8  9 10 11   4  5  6  7  8  9 10   4  5  6  7  8  9 10
#13 14 15 16 17 18 19  12 13 14 15 16 17 18  11 12 13 14 15 16 17  11 12 13 14 15 16 17
#20 21 22 23 24 25 26  19 20 21 22 23 24 25  18 19 20 21 22 23 24  18 19 20 21 22 23 24
#27 28 29 30 31        26 27 28 29 30        25 26 27 28 29 30     25 26 27 28 29 30 31
#
#     April 2022            July 2022            October 2022          January 2023
#Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
#                1  2                  1  2                     1   1  2  3  4  5  6  7
# 3  4  5  6  7  8  9   3  4  5  6  7  8  9   2  3  4  5  6  7  8   8  9 10 11 12 13 14
#10 11 12 13 14 15 16  10 11 12 13 14 15 16   9 10 11 12 13 14 15  15 16 17 18 19 20 21
#17 18 19 20 21 22 23  17 18 19 20 21 22 23  16 17 18 19 20 21 22  22 23 24 25 26 27 28
#24 25 26 27 28 29 30  24 25 26 27 28 29 30  23 24 25 26 27 28 29  29 30 31
#                      31                    30 31

if [[ -z "$1" ]]; then
	YEAR="$(date "+%Y")"
else
	YEAR="$1"
fi

NEXTYEAR=$((YEAR+1))
echo "YEAR $YEAR"
echo "NEXTYEAR $NEXTYEAR"
export YEAR
export NEXTYEAR
pr --omit-header -w 95 -m \
	<(ncal -b 2  "$YEAR";ncal -b 3  "$YEAR"; ncal -b 4  "$YEAR"; ) \
	<(ncal -b 5  "$YEAR";ncal -b 6  "$YEAR"; ncal -b 7  "$YEAR"; ) \
	<(ncal -b 8  "$YEAR";ncal -b 9  "$YEAR"; ncal -b 10 "$YEAR"; ) \
	<(ncal -b 11 "$YEAR";ncal -b 12 "$YEAR"; ncal -b 1  "$NEXTYEAR"; )
