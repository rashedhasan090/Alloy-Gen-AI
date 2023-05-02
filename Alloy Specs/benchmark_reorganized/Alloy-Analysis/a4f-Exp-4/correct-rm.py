import os

search_string = "--correct"
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
            # check if the search string is in the file contents
            if search_string in file_contents:
                # remove the search string from the file contents
                new_contents = file_contents.replace(search_string, "")
                # write the updated file contents back to the file
                with open(file_path, 'w') as f:
                    f.write(new_contents)
                #print(f"Removed {search_string} from {file_path}")
