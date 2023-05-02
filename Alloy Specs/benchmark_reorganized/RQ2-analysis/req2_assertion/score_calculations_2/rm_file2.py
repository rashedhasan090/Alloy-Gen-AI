import os

def remove_file_recursive(folder_path, file_name):
    for root, dirs, files in os.walk(folder_path):
        if file_name in files:
            file_path = os.path.join(root, file_name)
            try:
                os.remove(file_path)
                print(f"File removed: {file_path}")
            except FileNotFoundError:
                print(f"File not found: {file_path}")
            except IsADirectoryError:
                print(f"Cannot remove directory: {file_path}")
            except Exception as e:
                print(f"Error occurred while removing file: {file_path}")
                print(str(e))

# Specify the file name to be removed
file_name = 'student2_1.als'

# Call the function to remove the file recursively from the current directory
current_directory = os.getcwd()
remove_file_recursive(current_directory, file_name)
