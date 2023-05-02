import os

def rename_files_with_txt_extension():
    current_directory = os.getcwd()
    for root, dirs, files in os.walk(current_directory):
        for file in files:
            if file.endswith('.alsresult.txt'):
                old_path = os.path.join(root, file)
                new_path = os.path.join(root, file.replace('.alsresult.txt', '.als'))
                os.rename(old_path, new_path)
                # print(f'Renamed: {old_path} -> {new_path}')

rename_files_with_txt_extension()
