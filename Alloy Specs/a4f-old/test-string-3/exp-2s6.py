import os

# Set the directory path to search for files
directory = r'/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3'

# Set the string to search for
search_string = ' all a,b:Node'

# Set the string to add above the line containing the search string
add_string = '//Bug '

# Loop through all the files in the directory
for filename in os.listdir(directory):
    # Check that the file is a text file (you can adjust this as needed for your use case)
    if filename.endswith('.als'):
        # Open the file for reading and writing
        with open(os.path.join(directory, filename), 'r+') as f:
            # Read the file into a list of lines
            lines = f.readlines()
            # Loop through the lines and search for the search string
            for i, line in enumerate(lines):
                if search_string in line:
                    # If the search string is found, insert the new string one line above it
                    lines.insert(i, add_string + '\n')
                    break
            # Write the modified lines back to the file and save it
            f.seek(0)
            f.writelines(lines)
            f.truncate()
            print(f'Processed {filename}')
