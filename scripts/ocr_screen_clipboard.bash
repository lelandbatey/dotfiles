#!/bin/bash
# Dependencies: tesseract-ocr imagemagick scrot

# Description: You select an area of your screen, this command prints to stdout
#              the text recognized in that rectangular area.
#
# Original source: https://askubuntu.com/a/280713

TESSERACT_LANG="eng"
# Quick language menu, add more if you need other languages.
# select tesseract_lang in eng rus equ ;do break;done

SCR_IMG=`mktemp`
# In exit, ensures all the temporary files are deleted
trap "rm $SCR_IMG*" EXIT

scrot -s $SCR_IMG.png -q 100
# increase quality with option -q from default 75 to 100
# Typo "$SCR_IMG.png000" does not continue with same name.


#should increase detection rate
mogrify -modulate 100,0 -resize 400% $SCR_IMG.png

tesseract -l "${TESSERACT_LANG}" $SCR_IMG.png $SCR_IMG &> /dev/null
cat $SCR_IMG.txt
cat $SCR_IMG.txt | xclip -sel clipboard
exit
