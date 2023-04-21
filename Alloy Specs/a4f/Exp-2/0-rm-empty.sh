#!/bin/bash

# specify the directory containing the Alloy specification files
directory="/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-2"

# loop through all .als files in the directory
for file in $directory/*.als
do
  # remove empty lines from the file using sed
  sed -i '/^$/d' "$file"
done
