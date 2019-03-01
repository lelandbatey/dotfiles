#!/bin/bash

UTCNOW="$(TZ='UTC' date +'%a %b %d %H:%M:%S %p %Z %Y')"

printf "Current time in UTC/GMT: $UTCNOW (24 hour time)\n"
printf "                         $(TZ='UTC' date +'%a %b %d %I:%M:%S %p %Z %Y') (12 hour time)\n"
#printf "Current time here      : $(date)\n"
printf "Current time here      : $(date +'%a %b %d %H:%M:%S %p %Z %Y')\n"

