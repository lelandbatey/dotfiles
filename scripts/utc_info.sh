#!/bin/bash

if [[ -z "$1" ]]; then
	EPOCH_TIME="$(date "+%s")"
else
	EPOCH_TIME="$1"
fi

if [[ "${#EPOCH_TIME}" -gt "10" ]]; then
	EPOCH_TIME="$(printf "scale=5\n$EPOCH_TIME / 1000.00\n" | bc -l)"
fi
echo $EPOCH_TIME

UTCNOW="$(TZ='UTC' date -d "@$EPOCH_TIME" +'%a %b %d %H:%M:%S %p %Z %Y')"

printf "Time in UTC/GMT: $UTCNOW (24 hour time)\n"
printf "                 $(TZ='UTC' date -d "@$EPOCH_TIME" +'%a %b %d %I:%M:%S %p %Z %Y') (12 hour time)\n"
#printf "Current time here      : $(date)\n"
printf "Time here      : $(date -d "@$EPOCH_TIME" +'%a %b %d %H:%M:%S %p %Z %Y')\n"
GOLANG_HASH_TS="$(TZ='UTC' date -d "@$EPOCH_TIME" +'%Y%m%d%H%M%S')"
printf "Golang mod hash: $GOLANG_HASH_TS (for use as hash pseudo-version)\n"

