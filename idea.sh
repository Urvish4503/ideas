#!/bin/bash

# this is for testing purposes only.
# Default values
DEFAULT_PATH_IDEA="$HOME/Desktop/ideas/"
QUICK_NOTE_FILE="$DEFAULT_PATH_IDEA/quick_notes.md"
OPEN_FILE=false

# Function to display help
display_help() {
	echo "Usage: $0 [-q <note>] [-bd] [-h] [-o]"
	echo "Flags:"
	echo "  -q <note>  Add a quick note to the quick_notes.md file"
	echo "  -bd        Open the ideas.md file"
	echo "  -o         Open the ideas folder"
	echo "  -h         Display this help"
	echo "Read the docs at https://github.com/baba045/ideas/blob/main/README.md"
}

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-q)
		QUICK_NOTE="$2"
		shift 2
		;;
	-bd)
		OPEN_FILE=true
		shift
		;;
	-h)
		display_help
		exit 0
		;;
	-o)
		nvim "$DEFAULT_PATH_IDEA"
		exit 0
		;;
	*)
		echo "Invalid option: $1"
		display_help
		exit 1
		;;
	esac
done

if [ ! -d "$DEFAULT_PATH_IDEA" ]; then
	echo "Path does not exist: $DEFAULT_PATH_IDEA"
	echo "Read the docs at https://github.com/baba045/ideas/blob/main/README.md"
	echo "Exiting..."
	exit 1
fi

# Handle the -q flag
if [ -n "$QUICK_NOTE" ]; then
	if [ -f "$QUICK_NOTE_FILE" ]; then
		echo "$(date +"%Y-%m-%d %H:%M:%S") - $QUICK_NOTE" >>"$QUICK_NOTE_FILE"
	else
		mkdir -p "$(dirname "$QUICK_NOTE_FILE")"
		echo "$(date +"%Y-%m-%d %H:%M:%S") - $QUICK_NOTE" >"$QUICK_NOTE_FILE"
	fi
fi

# Handle the -bd flag
if $OPEN_FILE; then
	vim "$DEFAULT_PATH_IDEA/ideas.md"
fi
