import os

def delete_lines_with_string(file_path, string):
    # Read the file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Delete lines containing the string
    modified_lines = [line for line in lines if string not in line]

    # Write the modified lines back to the file
    with open(file_path, 'w') as file:
        file.writelines(modified_lines)

def search_and_delete(directory_path, string):
    for root, _, files in os.walk(directory_path):
        for file in files:
            if file.endswith('.txt'):
                file_path = os.path.join(root, file)
                delete_lines_with_string(file_path, string)

# Define the string to search for
search_string = "No Counterexample found"

# Get the current directory path
current_directory = os.getcwd()

# Search and delete lines with the given string in .txt files
search_and_delete(current_directory, search_string)
