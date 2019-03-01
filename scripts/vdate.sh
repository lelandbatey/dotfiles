#!/bin/bash

DaySuffix() {
  case `date +%d` in
    01|21|31) echo "st";;
    02|22)    echo "nd";;
    03|23)    echo "rd";;
    *)       echo "th";;
  esac
}

date "+%A, %B %d$(DaySuffix), %Y"
