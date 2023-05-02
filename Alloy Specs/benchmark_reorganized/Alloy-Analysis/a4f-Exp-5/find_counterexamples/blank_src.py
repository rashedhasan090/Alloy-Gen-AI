import os

def find_blank_files(directory):
    blank_files = []
    total_blank_files = 0
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".txt"):
                filepath = os.path.join(root, file)
                if os.stat(filepath).st_size == 0:
                    blank_files.append(file)
                    total_blank_files += 1
    return blank_files, total_blank_files

directory = "."  # Current directory
blank_files, total_blank_files = find_blank_files(directory)

print(f"Total blank files found: {total_blank_files}")
if total_blank_files > 0:
    print("Blank files:")
    for file in blank_files:
        print(file)
