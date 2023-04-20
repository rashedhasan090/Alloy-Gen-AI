import os

# set the directory where the files are located
directory = r'/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3'

# set the string to search for
string_to_find = ' all p:'

# set the string to attach to the beginning of the line when the string is found
new_string = '//Bug:'

# iterate through all files in the directory
for filename in os.listdir(directory):
    # check that the file is a .als file
    if filename.endswith('.als'):
        # read the contents of the file
        with open(os.path.join(directory, filename), 'r') as f:
            lines = f.readlines()

        # modify any lines that contain the specific string
        new_lines = []
        for line in lines:
            if string_to_find in line:
                line = new_string + line
            new_lines.append(line)

        # write the modified contents back to the file
        with open(os.path.join(directory, filename), 'w') as f:
            f.writelines(new_lines)
