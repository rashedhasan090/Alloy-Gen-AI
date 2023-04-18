import os

# Enter the directory path
directory = r"C:\Users\mhasan6\Downloads\Alloy-Gen-AI-main\Alloy-Gen-AI-main\Alloy-Specs\a4f\test-string-3"

# Enter the list of strings to be removed
strings_to_remove = ["--correct"]

# Loop through all files in the directory
for filename in os.listdir(directory):
    if filename.endswith(".als"):  # Change the file extension as needed
        filepath = os.path.join(directory, filename)

        # Open the file and read its contents
        with open(filepath, "r") as file:
            content = file.read()

        # Remove the specified strings from the file contents
        for string in strings_to_remove:
            content = content.replace(string, "")

        # Write the modified contents back to the file
        with open(filepath, "w") as file:
            file.write(content)
