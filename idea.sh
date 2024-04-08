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
	echo "  -q <note>           Add a quick note to the quick_notes.md file"
	echo "  -bd                 Open the ideas.md file"
	echo "  -o                  Open the ideas folder"
	echo "  -p <project>        opens the projects folder"
	echo "  -d <project>        opens the project file (dedicated to divya)"
	echo "  -k <project> <note> Add a quick note to the quick notes of <peoject>"
	echo "  -h                  Display this help"
	echo "Read the docs at https://github.com/baba045/ideas/blob/main/README.md"
}

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-q)
		if [ -z "$2" ]; then
			echo "Missing note"
			exit 1
		fi
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
	-p)
		if [ -z "$2" ]; then
			echo "Missing project name"
			exit 1
		fi

		if [ ! -d "$DEFAULT_PATH_IDEA/$2" ]; then

			read -r -p "Do you want to create a new project folder? [y/n]: " response

			if [[ "$response" == "y" ]]; then
				mkdir -p "$DEFAULT_PATH_IDEA/$2"
			else
				echo "Exiting..."
				exit 0
			fi
		fi

		nvim "$DEFAULT_PATH_IDEA/$2/$2.md"
		exit 0
		;;
	-d)
		result=$(find "$DEFAULT_PATH_IDEA" -type d | grep -i "$2")
		count=$(echo "$result" | wc -l)

		if [[ $count -eq 0 ]]; then
			echo "No such project found"
			exit 0
		elif [[ $count -gt 1 ]]; then
			echo "Please be more specific"
			echo $result
			exit 0
		else
			project=$(basename "$result")
			nvim "$result/$project.md"
		fi
		exit 0
		;;
	-k)
		if [ -z "$2" ]; then
			echo "Missing arguments"
			exit 1
		elif [ -z "$3" ]; then
			echo "Missing note"
			exit 1
		else

			result=$(find "$DEFAULT_PATH_IDEA" -type d | grep -i "$2")
			count=$(echo "$result" | wc -l)

			if [[ $count -eq 0 ]]; then
				echo "No such project found"
				exit 0
			elif [[ $count -gt 1 ]]; then
				echo "Please be more specific"
				echo $result
				exit 0
			else
				project=$(basename "$result")
				quick_note_file="$DEFAULT_PATH_IDEA/$project/$project.md"

				if [ -n "$quick_note_file" ]; then
					if [ -f "$quick_note_file" ]; then
						echo "$(date +"%Y-%m-%d %H:%M:%S") - $3" >>"$quick_note_file"
					else
						mkdir -p "$(dirname "$quick_note_file")"
						echo "$(date +"%Y-%m-%d %H:%M:%S") - $" >"$quick_note_file"
					fi
				fi
			fi
		fi

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
	mkdir -p "$DEFAULT_PATH_IDEA"
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
	nvim "$DEFAULT_PATH_IDEA/ideas.md"
fi
