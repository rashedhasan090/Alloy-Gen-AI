import os

def remove_files_by_extension(directory, extensions):
    for root, dirs, files in os.walk(directory):
        for file in files:
            filename, extension = os.path.splitext(file)
            if extension in extensions:
                file_path = os.path.join(root, file)
                os.remove(file_path)
                print("Removed file:", file_path)

# Get the current working directory
directory_path = os.getcwd()

# Specify the extensions of files to be removed
extensions_to_remove = ['.als']  # Replace with your desired extensions

# Call the function to remove files
remove_files_by_extension(directory_path, extensions_to_remove)
