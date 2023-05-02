import os

def search_string_in_files(directory_path, search_string):
    result = []
    count = 0

    for root, _, files in os.walk(directory_path):
        for file in files:
            if file.endswith('.txt'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r') as file:
                    lines = file.readlines()
                    for line in lines:
                        if search_string in line:
                            result.append(file_path)
                            count += 1
                            break

    return result, count

# Define the string to search for
search_string = "Counterexample found"

# Get the current directory path
current_directory = os.getcwd()

# Search for the string in .txt files
found_files, count = search_string_in_files(current_directory, search_string)

# Print the filenames and the number of files the string was found in
print(f"String found in {count} files:")
for file_path in found_files:
    print(file_path)

# Save the filenames and the count to a text file
with open("found_files.txt", "w") as file:
    file.write(f"String found in {count} files:\n")
    for file_path in found_files:
        file.write(file_path + "\n")
