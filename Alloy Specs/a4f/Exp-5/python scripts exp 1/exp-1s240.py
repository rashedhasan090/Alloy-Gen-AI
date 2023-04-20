import os

string_to_find = "-- all p,q,r"
directory_path = r"/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark/a4f/Exp-1"

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
