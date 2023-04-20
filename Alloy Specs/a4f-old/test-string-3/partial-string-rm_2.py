import os

# Replace this string with the string you want to replace the line with
new_line = "New line of text."

# Replace this string with the string you want to find in the files
old_line = "Old line of text."

# Replace this string with the string that needs to be present in the line to keep it
keep_line = "Keep this line"

# Specify the directory where the files are located
directory = "path/to/directory"

# Loop through all files in the directory
for filename in os.listdir(directory):
    # Check if the file is a text file
    if filename.endswith(".txt"):
        # Open the file in read mode
        with open(os.path.join(directory, filename), "r") as f:
            # Read all lines in the file
            lines = f.readlines()

        # Loop through each line in the file
        for i, line in enumerate(lines):
            # Check if the old string is in the line
            if old_line in line:
                # Check if the line contains the string that needs to be kept
                if keep_line in line:
                    # Keep the line without modification
                    continue
                else:
                    # Replace the line with the new string
                    lines[i] = new_line + "\n"

        # Open the file in write mode and save the changes
        with open(os.path.join(directory, filename), "w") as f:
            f.writelines(lines)
