import os

# Replace this string with the string you want to replace the line with
new_line = "//Bug:"

# Replace this string with the string you want to find in the files
old_line = " all c : Class |"

# Specify the directory where the files are located
directory = r"/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3"

# Loop through all files in the directory
for filename in os.listdir(directory):
    # Check if the file is a text file
    if filename.endswith(".sql"):
        # Open the file in read mode
        with open(os.path.join(directory, filename), "r") as f:
            # Read all lines in the file
            lines = f.readlines()

        # Loop through each line in the file
        for i, line in enumerate(lines):
            # Check if the old string is in the line
            if old_line in line:
                # Replace the line with the new string
                lines[i] = new_line + "\n"

        # Open the file in write mode and save the changes
        with open(os.path.join(directory, filename), "w") as f:
            f.writelines(lines)
