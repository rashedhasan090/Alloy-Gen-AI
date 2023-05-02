import os

def remove_als_files(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".txt"):
                file_path = os.path.join(root, file)
                os.remove(file_path)
                print(f"Deleted: {file_path}")

# Get the current working directory
current_directory = os.getcwd()

# Call the function to remove .als files
remove_als_files(current_directory)
