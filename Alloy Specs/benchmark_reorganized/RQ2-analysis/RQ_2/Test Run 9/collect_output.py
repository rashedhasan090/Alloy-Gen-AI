import os

def gather_text_outputs(root_directory, output_file):
    with open(output_file, 'w') as output:
        for folder_path, _, file_names in os.walk(root_directory):
            for file_name in file_names:
                if file_name.endswith('.txt'):
                    file_path = os.path.join(folder_path, file_name)
                    with open(file_path, 'r') as file:
                        output.write(f'File: {file_name}\n')
                        output.write(file.read())
                        output.write('\n\n')

# Example usage:
root_directory = '.'  # Replace with the root directory path you want to search
output_file = 'output.txt'  # Replace with the desired output file name

gather_text_outputs(root_directory, output_file)
