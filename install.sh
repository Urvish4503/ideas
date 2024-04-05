#!/bin/bash

# Copy the script to the user's home directory
cp idea.sh ~/idea.sh

sudo chmod +x ~/idea.sh

# Create an alias in the user's shell configuration file
shell_config_file=""
if [ -f "$HOME/.zshrc" ]; then
elif [ -f "$HOME/.bashrc" ]; then
	shell_config_file="$HOME/.zshrc"
	shell_config_file="$HOME/.bashrc"
elif [ -f "$HOME/.bash_profile" ]; then
	shell_config_file="$HOME/.bash_profile"
else
	echo "Unable to find the user's shell configuration file."
	exit 1
fi

echo "alias baba='~/idea.sh'" >>$shell_config_file
source $shell_config_file

echo "Global setup complete. You can now run 'baba' from any directory."

# Get the current directory (assumed to be the Git repository)
repo_dir=$(pwd)

# Move up one directory to delete the Git repository
cd ..
rm -rf "$repo_dir"

echo "Git repository deleted."
