import os

# specify the directory containing the Alloy specification files
# directory = "/path/to/directory"

# loop through all .als files in the directory and its subdirectories
for root, dirs, files in os.walk("."):
    for filename in files:
        if filename.endswith(".als"):
            filepath = os.path.join(root, filename)
            with open(filepath, "r") as file:
                # read the file contents into a string
                file_contents = file.read()
            # remove empty lines from the file using os.linesep
            file_contents = os.linesep.join([line for line in file_contents.splitlines() if line.strip()])
            with open(filepath, "w") as file:
                # write the modified contents back to the file
                file.write(file_contents)
