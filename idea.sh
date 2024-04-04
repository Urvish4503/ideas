#!/bin/bash

# this is for testing purposes only.
DEFAULT_PATH="$HOME/Desktop/ideas/tests/ideas"

# check if the path exists
is_path_exists() {
	local file_path="$1"
	if [ -e "$file_path" ]; then
		echo "The path exists."
		cd "$file_path"
		return 0
	else
		echo nnnnnnnnnnnnnnnnooooooooooooooooo
		return 1
	fi
}

is_path_exists "$DEFAULT_PATH"
