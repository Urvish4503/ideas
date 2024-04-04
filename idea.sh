#!/bin/bash

# this is for testing purposes only.
DEFAULT_PATH="$HOME/Desktop/ideas/test/ideas"

# get default path

# check if the path exists
is_path_exists() {
	local path="$1"

	if [ -d "$path" ]; then
		return 0
	else
		return 1
	fi
}



if is_path_exists "$DEFAULT_PATH"; then
	nvim "$DEFAULT_PATH/idea.md"
else
	read -p "Path does not exist. Do you want to create it? [y/n]: " response
    if [ "$response" == "y" ]; then
        read -p "Enter the path: " path
        if is_path_exists $path; then
            nvim $path/idea.md
        else
            echo "Path does not exist. Exiting..."
            exit 1
        fi
    else
        echo "Exiting..."
        exit 1
fi

