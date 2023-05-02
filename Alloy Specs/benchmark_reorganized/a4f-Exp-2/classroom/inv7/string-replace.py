import os
import fileinput

# replace the following string with your target string
old_string = "inv7"

# replace the following string with your replacement string
new_string = "inv7"

# replace the following path with the path to your target folder
target_folder = "/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark_reorganized/a4f/classroom/inv7"

# loop through all .py files in the target folder and replace the old string with the new string
for file in os.listdir(target_folder):
    if file.endswith(".py"):
        file_path = os.path.join(target_folder, file)
        with fileinput.FileInput(file_path, inplace=True) as file:
            for line in file:
                print(line.replace(old_string, new_string), end='')
