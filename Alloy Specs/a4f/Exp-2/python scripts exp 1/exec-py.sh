#!/bin/bash

# Set the directory to search for Python scripts
directory="/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-1"

# Loop through all Python scripts in the directory and execute them
for file in $(find "$directory" -name "*.py"); do
    echo "Executing $file"
    python "$file"
done
