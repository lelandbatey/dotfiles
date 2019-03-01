#!/bin/bash

usage () {
	echo "Usage:"
	echo " $(basename $0) -o organization"
	echo ""
	echo "Options:"
	echo " -o <string>      organization within gitlab from which to clone all"
	echo "                    the repos (default: 'engineering')"
	echo " -l               list the names of all repos in the organization on"
	echo "                    stdout (does not clone the repos)"
	echo ""
	exit 1
}

ORG="engineering"
LISTONLY=false
while getopts o:l opt; do
	case $opt in
	o)
		ORG=$OPTARG
		;;
	l)
		LISTONLY=true
		;;
	:)
		echo "Option -$OPTARG requires an argument." >&2
		usage
		;;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		usage
		;;
	esac
done

TOKEN=""
URL="https://GITLAB_INSTANCE_HOSTNAME/api/v4/groups/$ORG/projects?private_token=$TOKEN&per_page=100"

page=1
while true; do
	repo_count=$(curl -s "$URL&page=$page" | jq '.|length')
	if [ "$repo_count" -ne "0" ]; then
		>&2 echo "$URL&page=$page"
		if [ "$LISTONLY" == true ]; then
			curl -s "$URL&page=$page" | jq '.[].name' -r
		else
			curl -s "$URL&page=$page" | jq '.[].name' -r | while read line; do echo "$line"; lab clone "$ORG/$line"; done
		fi
	else
		break
	fi
	page=$((page+1))
done

#curl -s "$URL" | jq '.[].name' -r

# Example of how to clone all these repositories
# curl "$URL" | jq '.[].name' -r | while read line; do lab clone "engineering/$line"; done



