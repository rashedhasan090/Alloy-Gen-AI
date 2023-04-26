import os

folder_path = '/Users/rashedhasan/Downloads/atmprep-master/atmprep-master-2/benchmark_reorganized/a4f/classroom/inv14_1' # Replace with the path to your folder
string_to_find = '--  ' # Replace with the string you want to find
string_to_delete = '--correct' # Replace with the string you want to delete

for file_name in os.listdir(folder_path):
    if file_name.endswith('.als'):
        file_path = os.path.join(folder_path, file_name)
        with open(file_path, 'r+') as file:
            lines = file.readlines()
            file.seek(0) # Set the file pointer to the beginning of the file
            file.truncate() # Clear the contents of the file
            for line in lines:
                if string_to_find in line:
                    line = line.replace(string_to_delete, '')
                file.write(line)
