import os

# specify the directory containing the .als files
# directory = "/path/to/directory"

# specify the string to search for and the string to add
string_to_search = "-- 	"
string_to_add = "//Bug "

# loop through all .als files in the directory and its subdirectories
for root, dirs, files in os.walk("."):
    for filename in files:
        if filename.endswith(".als"):
            filepath = os.path.join(root, filename)
            with open(filepath, "r") as file:
                # read the file contents into a list of lines
                lines = file.readlines()
            # iterate over the lines and add the string after the line with the search string
            for i, line in enumerate(lines):
                if string_to_search in line:
                    lines.insert(i + 1, string_to_add + "\n")
            with open(filepath, "w") as file:
                # write the modified contents back to the file
                file.writelines(lines)
