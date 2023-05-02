#!/bin/bash

# replace the following string with your target string
OLD_STRING="inv10"

# replace the following string with your replacement string
NEW_STRING="inv1to4"

# replace the following path with the path to your target folder
TARGET_FOLDER="/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark_reorganized/a4f/classroom/inv1to4"

# loop through all .py files in the target folder and replace the old string with the new string
for file in "$TARGET_FOLDER"/*.py
do
    sed -i "s/$OLD_STRING/$NEW_STRING/g" "$file"
done
