import os

# Define the string to search for and the string to add
search_string = "--	"
add_string = " --correct"

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
                    if search_string in line:
                        # If the search string is found in the line, add the new string to the end
                        line = line.strip() + " " + add_string + "\n"
                    f.write(line)
                f.close()
