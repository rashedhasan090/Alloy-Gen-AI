#!/bin/bash

# Change to the root directory
root_directory="."  # Replace with the root directory path you want to search
cd "$root_directory" || exit

# Find all subdirectories
subdirectories=$(find . -type d)

# Loop through each subdirectory and run collect_output0.py script
for directory in $subdirectories; do
    # Skip the root directory and non-empty directories
    if [[ $directory != "." && ! -z "$(ls -A $directory)" ]]; then
        # Run the collect_output0.py script in the current directory
        echo "Running collect_output0.py in directory: $directory"
        cd "$directory" || continue
        python3 collect_output0.py
        cd "$root_directory"  # Return to the root directory
    fi
done
