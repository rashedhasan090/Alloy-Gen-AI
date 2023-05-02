import os

def search_text_files():
    count = 0
    file_names = []

    # Traverse through all the directories and files
    for root, dirs, files in os.walk("."):
        for file in files:
            # Check if the file is a text file
            if file.endswith(".txt"):
                file_path = os.path.join(root, file)

                # Open the text file and read its contents
                with open(file_path, "r") as text_file:
                    content = text_file.read()

                # Check if the file does not contain "Syntax error" or "Type error"
                if "Syntax error" not in content and "Type error" not in content:
                    # Check if the string "No" is not present in the file
                    if "No" not in content:
                        count += 1
                        file_names.append(file_path)

    # Save the results to the counter.txt file
    with open("counter.txt", "w") as output_file:
        output_file.write(f"Number of files without 'No': {count}\n")
        output_file.write("File Names:\n")
        for file_name in file_names:
            output_file.write(f"{file_name}\n")

    return count, file_names

# Execute the search
result = search_text_files()
print(f"Number of files without 'No': {result[0]}")
print("File Names:")
for file_name in result[1]:
    print(file_name)
