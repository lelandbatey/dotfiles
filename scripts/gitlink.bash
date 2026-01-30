#!/bin/bash

# Usage: gitlink.sh	PATH LINENO
# Prints a URL which opens the file at the line number in github/gitlab/etc

usage() {
	echo "Usage: $(basename $0) \"PATH\" \"LINENO\"";
	echo "Prints a URL which opens the file at the line number in github/gitlab/etc"
	exit 1;
}

print_gitlink() {
	local filepath="$1"
	local lineno="$2"

	# Validate file exists
	if [ ! -f "$filepath" ]; then
		echo "Error: File '$filepath' does not exist" >&2
		exit 1
	fi

	# Get the directory containing the file
	local filedir
	filedir="$(dirname "$filepath")"

	# Step 1: Get the current commit hash
	local hash
	hash=$(git -C "$filedir" rev-parse HEAD 2>/dev/null)
	if [ $? -ne 0 ] || [ -z "$hash" ]; then
		echo "Error: Not a git repository or unable to get HEAD commit" >&2
		exit 1
	fi

	# Step 2: Get absolute path to the file
	local abspath
	abspath=$(realpath "$filepath" 2>/dev/null)
	if [ $? -ne 0 ] || [ -z "$abspath" ]; then
		echo "Error: Unable to resolve absolute path for '$filepath'" >&2
		exit 1
	fi

	# Check if file is tracked by git
	git -C "$filedir" ls-files --error-unmatch "$abspath" >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "Error: File is not tracked by git repository" >&2
		exit 1
	fi

	# Check for uncommitted changes to this file
	local diff_output
	diff_output=$(git -C "$filedir" diff "$abspath" 2>/dev/null)
	if [ -n "$diff_output" ]; then
		echo "Error: File has uncommitted changes. Please commit and push changes before linking to it." >&2
		exit 1
	fi

	# Get the repository root
	local root
	root=$(git -C "$filedir" rev-parse --show-toplevel 2>/dev/null)
	if [ $? -ne 0 ] || [ -z "$root" ]; then
		echo "Error: Unable to find git repository root" >&2
		exit 1
	fi

	# Step 3: Calculate relative path from repo root
	local relpath="${abspath#$root}"

	# Step 4: Get remote URL
	local remote
	remote=$(git -C "$filedir" config --get remote.origin.url 2>/dev/null)
	if [ $? -ne 0 ] || [ -z "$remote" ]; then
		echo "Error: Unable to get remote.origin.url" >&2
		exit 1
	fi

	# Remove .git suffix and any trailing newlines
	remote="${remote%.git}"
	remote="${remote//$'\n'/}"

	# Convert remote URL to HTTPS format
	local repoURL
	if [[ "$remote" =~ ^https:// ]]; then
		# Already HTTPS
		repoURL="$remote"
	elif [[ "$remote" =~ ^git@ ]]; then
		# SSH format: git@github.com:user/repo
		repoURL="${remote#git@}"
		repoURL="https://${repoURL/://}"
	elif [[ "$remote" =~ ^ssh:// ]]; then
		# SSH URL format: ssh://git@github.com/user/repo
		repoURL="${remote#ssh://}"
		repoURL="https://${repoURL#*@}"
	elif [[ "$remote" =~ ^git: ]]; then
		# Git protocol: git://github.com/user/repo
		repoURL="${remote#git:}"
		repoURL="https:${repoURL}"
	else
		echo "Error: Unsupported remote URL format: $remote" >&2
		exit 1
	fi

	# Construct and print the final URL
	local final_url="${repoURL}/tree/${hash}${relpath}#L${lineno}"
	echo "$final_url"
}

if [ "$#" -ne	2 ]; then
	 usage;
	 exit 1;
else
	 print_gitlink "$@";
fi;

