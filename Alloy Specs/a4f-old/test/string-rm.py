import os

# specify the directory path
dir_path = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/a4f/test"

# specify the string to be kept
keep_string = "INSTA:"

# loop through all the files in the directory
for file_name in os.listdir(dir_path):
    if file_name.endswith(".txt"): # specify the file extension
        file_path = os.path.join(dir_path, file_name)
        with open(file_path, "r+") as f:
            lines = f.readlines() # read all the lines in the file
            f.seek(0) # set the file pointer to the beginning of the file
            for line in lines:
                if keep_string in line:
                    # keep the part of the line that contains the keep_string
                    new_line = line[line.index(keep_string):] + "\n"
                    f.write(new_line)
                else:
                    f.write("\n") # delete the rest of the line and write a new line character
            f.truncate() # truncate the remaining content of the file
