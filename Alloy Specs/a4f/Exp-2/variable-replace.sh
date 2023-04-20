#!/bin/bash

# Set the directory to search for Python files
directory="/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-1"

# Set the variable name and new value
var_name="directory_path = r'/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3'"
new_value="directory_path = r'/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-1'"

# Search for all Python files in the directory and loop through them
for file in $(find "$directory" -name "*.py"); do
    # Replace the variable value in the file and save the changes
    sed -i "s/$var_name = .*/$var_name = $new_value/g" "$file"
done
