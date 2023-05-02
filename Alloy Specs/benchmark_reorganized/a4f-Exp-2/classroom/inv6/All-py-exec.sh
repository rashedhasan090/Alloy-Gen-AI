#!/bin/bash

# Enter the directory containing Python files to be executed
cd /Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark_reorganized/a4f/classroom/inv6

# Define the array of files to exclude
EXCLUDED_FILES=("string-replace.py" "empty-line-remover.py" "exp-incorrect-remover.py")

# Loop through all Python files in the directory and execute them if they're not in the exclude list
for file in *.py; do
  if [[ ! " ${EXCLUDED_FILES[@]} " =~ " ${file} " ]]; then
    python "${file}"
  fi
done
