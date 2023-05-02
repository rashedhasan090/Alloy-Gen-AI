import os

def find_string_in_files(directory):
    instances = {}
    total_files = 0
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".txt"):
                total_files += 1
                filepath = os.path.join(root, file)
                with open(filepath, 'r+') as f:
                    content = f.read()
                    if "Counterexample found" in content:
                        continue
                    if "Instance found" in content:
                        instances[file] = instances.get(file, 0) + 1
    return instances, total_files

def save_results_to_file(results, total_files):
    with open("instance_found.txt", "w") as f:
        f.write(f"Total files searched: {total_files}\n")
        f.write(f"Total files with 'Instance found': {len(results)}\n")
        for filename, count in results.items():
            f.write(f"{filename}: {count} files\n")

directory = "."  # Current directory
instances, total_files = find_string_in_files(directory)
save_results_to_file(instances, total_files)

print(f"Search completed. Total files found: {len(instances)}")
print("Results saved in instance_found.txt.")
