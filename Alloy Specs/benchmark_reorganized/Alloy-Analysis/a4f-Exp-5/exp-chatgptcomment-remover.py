import os
import fileinput

def search_and_delete_strings(root_dir, search_strings):
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.als'):  # Modify the file extension as needed
                filepath = os.path.join(root, file)
                modified = False
                with fileinput.FileInput(filepath, inplace=True) as f:
                    for line in f:
                        if any(search_string in line for search_string in search_strings):
                            modified = True
                            continue
                        print(line, end='')

                if modified:
                    print(f"String(s) {', '.join(search_strings)} found in '{filepath}'. Line(s) deleted.")

# Usage example
directory = "."  # Current working directory
search_strings = ["Fixed Alloy specification:",  "The bug in this specification", "With this fix,", "Here is the fixed specification:",
 "The bug in the specification", "Fixed specification:", "The bug in the", "The correct definition of the complete predicate is:",
 "Fixed Alloy specification:", "With this modification, the assertions are all satisfied by the specification.",
 "The repaired specification", "This predicate states", "The fixed Alloy specification is:", "Bug fix:", "The repaired Alloy specification is as follows:",
 "The repaired Alloy specification is as follows:", "Here is the repaired Alloy specification:", "Here is the complete", "The fixed acyclic"
 "```", "Fixed version:", "The bug is in", "Fixed version of", "With this correction," "Fixed code:"
]

search_and_delete_strings(directory, search_strings)
