import os

# set the directory where the files are located
#directory = r'/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3'
directory = r"/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-5"

# set the string to search for
string_to_remove = 'of which are'

# iterate through all files in the directory
for filename in os.listdir(directory):
    # check that the file is a text file
    if filename.endswith('.als'):
        # read the contents of the file
        with open(os.path.join(directory, filename), 'r') as f:
            lines = f.readlines()

        # remove any lines that contain the specific string
        new_lines = [line for line in lines if string_to_remove not in line]

        # write the modified contents back to the file
        with open(os.path.join(directory, filename), 'w') as f:
            f.writelines(new_lines)
