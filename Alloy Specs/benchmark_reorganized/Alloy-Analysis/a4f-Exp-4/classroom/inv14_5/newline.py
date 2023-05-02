import os
import re

# Define the string to search for
search_string = "-- "

# Define the regex pattern to find the search string
pattern = re.compile(search_string)

# Define the directory to search
directory = "/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark_reorganized/a4f/classroom/inv14_5"

# Traverse the directory and search for the search string in each file
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith(".als"):  # Only search Alloy files
            file_path = os.path.join(root, file)
            with open(file_path, "r+") as f:
                lines = f.readlines()
                f.seek(0)
                f.truncate()
                for line in lines:
                    match = pattern.search(line)
                    if match:
                        # If the search string is found, split the line and write the first part to the original line
                        f.write(line[:match.start()])
                        # Write everything after the search string to a new line
                        f.write("\n" + line[match.start():])
                    else:
                        # If the search string is not found, write the original line to the file
                        f.write(line)
                f.close()
