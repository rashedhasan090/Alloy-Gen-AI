import os

def replace_dash_in_als_files(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.als'):
                file_path = os.path.join(root, file)
                replace_dash_in_file(file_path)

def replace_dash_in_file(file_path):
    with open(file_path, 'r') as f:
        contents = f.read()

    modified_contents = contents.replace('-', '--')

    with open(file_path, 'w') as f:
        f.write(modified_contents)

replace_dash_in_als_files('.')
