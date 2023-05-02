import os

directory = "/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark_reorganized/a4f/classroom/inv14_1"
# replace with the path to your directory
line_to_detect = "-- "

# replace with the string you want to detect
string_to_delete = " --correct" # replace with the string you want to delete

for filename in os.listdir(directory):
    if filename.endswith(".als"): # check if the file is an alloy file
        filepath = os.path.join(directory, filename)
        with open(filepath, "r") as file:
            lines = file.readlines()

        with open(filepath, "w") as file:
            for line in lines:
                if line.startswith(line_to_detect):
                    line = line.rstrip(string_to_delete) + "\n"
                file.write(line)
