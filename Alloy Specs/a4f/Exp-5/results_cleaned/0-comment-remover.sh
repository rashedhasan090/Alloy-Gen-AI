#!/bin/bash

# List of Python scripts to run
SCRIPTS=("1-comment-remover.py" "2-comment-remover.py" "3-comment-remover.py" "4-comment-remover.py"
"5-comment-remover.py" "6-comment-remover.py" "7-comment-remover.py" "8-comment-remover.py" "9-comment-remover.py"
"10-comment-remover.py" "11-comment-remover.py" "12-comment-remover.py" "13-comment-remover.py" "14-comment-remover.py"
"15-comment-remover.py" "16-comment-remover.py" "17-comment-remover.py" "18-comment-remover.py" "19-comment-remover.py"
"20-comment-remover.py" "21-comment-remover.py" "22-comment-remover.py" "23-comment-remover.py")

# Loop through the list of scripts and run each one sequentially
for script in "${SCRIPTS[@]}"
do
    echo "Running $script"
    python "$script"
done
