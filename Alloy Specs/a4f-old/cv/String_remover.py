import os 



# Prompt user for folder path and string to delete
folder_path = input("Enter folder path: ")
string_to_delete = input("Enter string to delete: ")

# Iterate over all files in folder
for filename in os.listdir(folder_path):
    filepath = os.path.join(folder_path, filename)
    if os.path.isfile(filepath):
        # Open file in read mode
        with open(filepath, 'r') as file:
            # Read file contents
            file_contents = file.read()

        # Replace string with empty string
        new_contents = file_contents.replace(string_to_delete, '')

        # Open file in write mode and write new contents
        with open(filepath, 'w') as file:
            file.write(new_contents)
