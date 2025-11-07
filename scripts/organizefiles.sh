#!/bin/bash

DOTFILES_DIR="$(pwd)"

# List of files/directories to exclude (like .config, existing folders)
EXCLUDE=(.config)

# Function to check if an element exists in an array
contains() {
    local element match="$1"
    shift
    for element; do [[ "$element" == "$match" ]] && return 0; done
    return 1
}

# Loop through all files and directories in dotfiles folder
for item in "$DOTFILES_DIR"/.* "$DOTFILES_DIR"/*; do
    filename=$(basename "$item")

    # Skip . and ..
    if [[ "$filename" == "." || "$filename" == ".." ]]; then
        continue
    fi

    # Skip excluded items
    if contains "$filename" "${EXCLUDE[@]}"; then
        echo "Skipping $filename"
        continue
    fi

    # Skip directories (like .config)
    if [ -d "$item" ]; then
        echo "Skipping directory $filename"
        continue
    fi

    # Remove leading dot to create package folder name
    # Example: .zshrc -> zshrc
    if [[ "$filename" == .* ]]; then
        package_name="${filename:1}"
    else
        package_name="$filename"
    fi

    # Create package folder if it doesn't exist
    if [ ! -d "$DOTFILES_DIR/$package_name" ]; then
        echo "Creating folder $package_name"
        mkdir "$DOTFILES_DIR/$package_name"
    else
        echo "Folder $package_name already exists, skipping creation"
    fi

    # Move the file into the package folder if not already there
    if [ "$(dirname "$item")" != "$DOTFILES_DIR/$package_name" ]; then
        echo "Moving $filename into $package_name/"
        mv "$item" "$DOTFILES_DIR/$package_name/"
    else
        echo "$filename is already in $package_name/, skipping move"
    fi

done

echo "Dotfiles organization complete!"
