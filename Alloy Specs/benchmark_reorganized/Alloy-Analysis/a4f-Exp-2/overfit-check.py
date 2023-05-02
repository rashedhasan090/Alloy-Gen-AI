import os
import glob

def search_files(directory, search_strings):
    # List to store filenames and their occurrence count
    results = {string: [] for string in search_strings}

    # Traverse the directory recursively
    for root, dirs, files in os.walk(directory):
        # Search for text files
        text_files = glob.glob(os.path.join(root, "*.txt"))

        for file in text_files:
            # Open each text file
            with open(file, "r") as f:
                content = f.read()

                # Count the occurrences of the search strings
                for string in search_strings:
                    count = content.count(string)

                    if count > 0:
                        # Add the filename and count to the results list
                        results[string].append((file, count))

    return results

def save_results(results):
    # Save the results to separate text files and print the total counts
    for string, file_counts in results.items():
        filename = string.lower().replace(" ", "_") + ".txt"
        with open(filename, "w") as f:
            for i, result in enumerate(file_counts, 1):
                file, count = result
                f.write(f"{i}. File: {file} - Count: {count}\n")
        print(f"Search results for '{string}' saved to {filename}")
        print(f"Total instances found: {len(file_counts)}\n")

# Define the search directory and strings
directory = "."  # Current directory
search_strings = ["Instance found"]

# Perform the search
results = search_files(directory, search_strings)

# Save the results
save_results(results)
