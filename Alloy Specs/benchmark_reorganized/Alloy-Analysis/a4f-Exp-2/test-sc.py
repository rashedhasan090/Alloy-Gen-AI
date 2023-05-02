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

                # Check for the presence of all three strings in the file
                if "Counterexample found" in content and "No Counterexample found" in content and "Instance found" in content:
                    count += 1
                    file_names.append(file_path)

    # Save the results to the output file if there are any matching files
    if count > 0:
        with open("search_results.txt", "w") as output_file:
            output_file.write(f"Number of files: {count}\n")
            output_file.write("File Names:\n")
            for file_name in file_names:
                output_file.write(f"{file_name}\n")

    return count, file_names

# Execute the search
result = search_text_files()
print(f"Number of files: {result[0]}")
print("File Names:")
for file_name in result[1]:
    print(file_name)
