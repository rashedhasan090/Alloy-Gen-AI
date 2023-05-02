import os

string_to_delete = "--correct"
other_string = "--	"

# Find all .als files in the current directory and its subdirectories
for root, dirs, files in os.walk("."):
    for filename in files:
        if filename.endswith(".als"):
            filepath = os.path.join(root, filename)
            # Read the entire file into memory
            with open(filepath, "r") as file:
                contents = file.read()
            # Replace the specified string with an empty string on each line that contains both strings
            new_contents = ""
            for line in contents.splitlines():
                if string_to_delete in line and other_string in line:
                    line = line.replace(string_to_delete, "")
                new_contents += line + "\n"
            # Write the updated contents back to the file
            with open(filepath, "w") as file:
                file.write(new_contents)
