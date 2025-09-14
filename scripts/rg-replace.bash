#!/bin/bash

# Originally based on ag-replace.sh:
#     https://gist.github.com/adamryman/1de22e36a14c29da2f41c8512cb86b6d

usage() {
	echo "Usage: $(basename $0) \"THIS\" \"THAT\"";
	echo "Replaces all instances of THIS with THAT in all files which contain THIS."
	echo "Additionally, prints each file as that file is modified"
	exit 1;
}


replace() {
	escaped1=$(echo "$1" | sed -e 's/[\/&]/\\&/g');
	escaped2=$(echo "$2" | sed -e 's/[\/&]/\\&/g');

	# list only the file names of files with this literal string, case sensitive
	files=$(rg "$1" --fixed-strings --case-sensitive --files-with-matches ./)
	echo "$files" | while read line; do
		echo "$line"
		sed -i "s/$escaped1/$escaped2/g" "$(pwd)"/"$line";
	done;
}


if [ "$#" -ne  2 ]; then
	 usage;
	 exit 1;
else
	 replace "$@";
fi;
