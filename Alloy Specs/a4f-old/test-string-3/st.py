import os

folder_path = r"C:\Users\mhasan6\Downloads\Alloy-Gen-AI-main\Alloy-Gen-AI-main\Alloy-Specs\a4f\test-string-3"
search_string = "-- "

for filename in os.listdir(folder_path):
    filepath = os.path.join(folder_path, filename)
    with open(filepath, "r") as file:
        lines = file.readlines()
    with open(filepath, "w") as file:
        for line in lines:
            if not line.startswith(search_string):
                file.write(line)
