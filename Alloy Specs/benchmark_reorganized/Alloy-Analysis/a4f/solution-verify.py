import os

search_string_1 = "No Counterexample found"
search_string_2 = "Counterexample found"

def search_strings_in_files(directory):
    count = 0
    result = []

    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.txt'):  # Modify the file extension as per your requirement
                file_path = os.path.join(root, file)
                found_strings = search_strings_in_file(file_path)

                if search_string_1 in found_strings and search_string_2 in found_strings:
                    count += 1
                    result.append((file_path, found_strings))

    print("Number of files with both strings:", count)
    save_result_to_file(result)

def search_strings_in_file(file_path):
    found_strings = {}

    with open(file_path, 'r') as f:
        contents = f.read()

    found_strings[search_string_1] = contents.count(search_string_1)
    found_strings[search_string_2] = contents.count(search_string_2)

    return found_strings

def save_result_to_file(result):
    with open('search_results.txt', 'w') as f:
        f.write("Number of files with both strings: " + str(len(result)) + "\n\n")

        for file_path, found_strings in result:
            f.write("File: " + file_path + "\n")
            f.write("Occurrences:\n")
            for search_string, count in found_strings.items():
                f.write(search_string + ": " + str(count) + "\n")
            f.write("\n")

search_strings_in_files('.')
