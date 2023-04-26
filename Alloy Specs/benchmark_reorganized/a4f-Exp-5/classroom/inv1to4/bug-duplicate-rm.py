import os
import re

search_string = "//Bug "
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
            # find all occurrences of the search string in the file
            matches = re.findall(search_string, file_contents)
            # remove duplicates and keep only the first occurrence
            unique_matches = list(set(matches))
            # replace all occurrences of the search string with the unique match
            new_contents = file_contents
            for match in matches:
                if match in unique_matches:
                    unique_matches.remove(match)
                else:
                    new_contents = new_contents.replace(match, "")
            # write the updated file contents back to the file
            with open(file_path, 'w') as f:
                f.write(new_contents)
            print(f"Removed duplicates of {search_string} from {file_path}")
