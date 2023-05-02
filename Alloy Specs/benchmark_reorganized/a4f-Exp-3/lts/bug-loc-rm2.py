import os

# set the directory where the files are located
# directory = "/path/to/directory"

# set the string to search for
string_to_remove = "--   let"

# iterate through all files in the directory and its subdirectories
for root, dirs, files in os.walk("."):
    for filename in files:
        # check that the file is a text file
        if filename.endswith('.als'):
            # read the contents of the file
            with open(os.path.join(root, filename), 'r') as f:
                lines = f.readlines()

            # remove any lines that contain the specific string
            new_lines = [line for line in lines if string_to_remove not in line]

            # write the modified contents back to the file
            with open(os.path.join(root, filename), 'w') as f:
                f.writelines(new_lines)
