import os
import re

# specify the directory containing the Alloy specification files
directory = "/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-2"

# loop through all .als files in the directory
for filename in os.listdir(directory):
    if filename.endswith(".als"):
        filepath = os.path.join(directory, filename)
        with open(filepath, "r") as file:
            # read the file contents into a string
            file_contents = file.read()
        # remove empty lines from the file using regex
        file_contents = re.sub(r'^\s*\n', '', file_contents, flags=re.MULTILINE)
        with open(filepath, "w") as file:
            # write the modified contents back to the file
            file.write(file_contents)
