import os
import re

string_to_remove = "//Bug"
file_extension = ".als" # specify the file extension you want to search for

# loop through all files and directories in the current directory
for root, dirs, files in os.walk('.'):
    for file in files:
        # check if the file has the specified extension
        if file.endswith(file_extension):
            file_path = os.path.join(root, file)
            # read the contents of the file
            with open(file_path, 'r') as f:
                file_contents = f.read()
            # remove the specified string from the file contents
            new_contents = file_contents.replace(string_to_remove, "")
            # write the updated file contents back to the file
            with open(file_path, 'w') as f:
                f.write(new_contents)
            print(f"Removed {string_to_remove} from {file_path}")
