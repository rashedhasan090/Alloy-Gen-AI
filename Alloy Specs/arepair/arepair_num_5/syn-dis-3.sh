#!/bin/bash

# Set the paths to the two folders containing the files
folder1="/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_5"
folder2="/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_5/arepair-chres-exp5"


# Initialize variables for total distance and number of pairs
total_distance=0
num_pairs=0

# Loop through all files in folder1
for file1 in "$folder1"/*
do
    # Get the filename of the current file in folder1
    filename=$(basename "$file1")

    # Check if a file with the same name exists in folder2
    if [ -e "$folder2/$filename" ]
    then
        # Calculate the syntactic distance using difflib
        distance=$(python -c "import difflib; print(difflib.SequenceMatcher(None, open('$file1').read(), open('$folder2/$filename').read()).ratio())")

        # Print the distance for the current pair of files, with only the file names
        echo "Syntactic distance between $filename and ${folder2##*/}/$filename: $distance"

        # Add the distance to the total and increment the number of pairs
        total_distance=$(echo "$total_distance + $distance" | bc)
        num_pairs=$(expr $num_pairs + 1)
    fi
done

# Calculate the average distance and print the result
if [ $num_pairs -eq 0 ]
then
    echo "No matching pairs of files found."
else
    avg_distance=$(echo "scale=2; $total_distance / $num_pairs" | bc)
    echo "Average syntactic distance: $avg_distance"
fi
