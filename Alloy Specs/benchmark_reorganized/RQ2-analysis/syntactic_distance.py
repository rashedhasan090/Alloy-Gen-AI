import difflib
import os
from pathlib import Path

# Function to calculate syntactical distance between two files
def calculate_distance(file1, file2):
    try:
        with open(file1, 'r', encoding='utf-8') as f1, open(file2, 'r', encoding='utf-8') as f2:
            lines1 = f1.readlines()
            lines2 = f2.readlines()
    except UnicodeDecodeError:
        print(f"Warning: Skipped file due to decoding error: {file1} or {file2}")
        return None

    # Use difflib to calculate the syntactical distance
    diff = difflib.unified_diff(lines1, lines2)
    distance = sum(1 for _ in diff)

    return distance

# Main folder path containing files to compare
main_folder = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/original files'

# List of other folders to compare with
other_folders = [
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 1',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 2',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 3',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 4',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 5',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 6',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 7',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 8',
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 9',
    # ... Add more folders here ...
    '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/RQ_2/Test Run 10'
]

# Output file to save the distance values
output_file = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/RQ2-analysis/output.txt'

# Create a list to store average distance values
average_distances = []

# Iterate over files in the main folder
for main_file in os.listdir(main_folder):
    distances = []

    # Iterate over other folders
    for other_folder in other_folders:
        other_file = Path(other_folder) / main_file

        # Check if the file exists in the other folder
        if other_file.is_file():
            distance = calculate_distance(Path(main_folder) / main_file, other_file)
            if distance is not None:
                distances.append(distance)

    # Calculate the average distance for the main file
    average_distance = sum(distances) / len(distances) if distances else 0
    average_distances.append(average_distance)

    # Save distance values to the output file
    with open(output_file, 'a') as f:
        f.write(f"File: {main_file}\n")
        f.write(f"Distances: {distances}\n")
        f.write(f"Average Distance: {average_distance}\n\n")

# Report the average syntactical value for each folder
for i, folder in enumerate(other_folders):
    print(f"Average distance for {folder}: {average_distances[i]}")
