import os

string_to_find = "--  all c :"
directory_path = r"/Users/rashedhasan/Desktop/UNL/Research/Object relational mapping/Step 5 - Abstraction/OM-Solution_Mapping/Alloy-Gen-AI/Alloy Specs/a4f/test-string-3"

for filename in os.listdir(directory_path):
    if filename.endswith(".als"): # or any other file extension you want to modify
        filepath = os.path.join(directory_path, filename)
        with open(filepath, "r") as file:
            lines = file.readlines()
        for i in range(len(lines)):
            if string_to_find in lines[i]:
                lines[i] = lines[i].split(string_to_find)[0] + "\n"
        with open(filepath, "w") as file:
            file.writelines(lines)
