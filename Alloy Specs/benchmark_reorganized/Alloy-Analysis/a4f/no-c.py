import os

def search_text_files():
    count = 0
    total_files = 0

    # Open the output file to save the results
    with open("search_results.txt", "w") as output_file:
        # Traverse through all the directories and files
        for root, dirs, files in os.walk("."):
            for file in files:
                # Check if the file is a text file
                if file.endswith(".txt"):
                    total_files += 1
                    file_path = os.path.join(root, file)

                    # Open the text file and read its contents
                    with open(file_path, "r") as text_file:
                        content = text_file.read()

                    # Check if the exact string "No Counterexample found" is present
                    if "No Counterexample found" in content:
                        # Check if "Counterexample found" is not present in the file
                        if "Counterexample found" not in content:
                            count += 1

                            # Write the file path to the output file
                            output_file.write(f"File: {file_path}\n")

    # Write the results to the output file
    with open("search_results.txt", "a") as output_file:
        output_file.write(f"\nNumber of files with 'No Counterexample found': {count}\n")
        output_file.write(f"Total number of text files searched: {total_files}\n")

    return count, total_files

# Execute the search
result = search_text_files()
print(f"Number of files with 'No Counterexample found': {result[0]}")
print(f"Total number of text files searched: {result[1]}")
