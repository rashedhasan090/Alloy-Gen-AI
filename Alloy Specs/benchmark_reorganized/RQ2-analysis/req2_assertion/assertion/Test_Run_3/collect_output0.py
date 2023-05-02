import os

def gather_text_outputs(root_directory, output_file):
    with open(output_file, 'w') as output:
        for folder_path, _, file_names in os.walk(root_directory):
            parent_folder_name = os.path.basename(os.path.dirname(folder_path))
            for file_name in file_names:
                if file_name.endswith('.txt'):
                    file_path = os.path.join(folder_path, file_name)
                    with open(file_path, 'r') as file:
                        output.write(f'Folder: {parent_folder_name}\n')
                        output.write(f'File: {file_name}\n')
                        output.write(file.read())
                        output.write('\n\n')

# Example usage:
root_directory = '.'  # Replace with the root directory path you want to search
output_file = 'output.txt'  # Replace with the desired output file name

output_file_name = os.path.splitext(output_file)[0]
parent_folder_name = os.path.basename(os.path.dirname(root_directory))
output_file = f'{output_file_name}_{parent_folder_name}.txt'

gather_text_outputs(root_directory, output_file)
