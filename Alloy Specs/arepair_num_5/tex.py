import os
import subprocess

# Set the path to the Alloy 4.2 jar file
alloy_jar_path = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Bug_Replace_Fix_num_2/alloy4.2.jar"

# Set the path to the folder containing the .als files
folder_path = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_Bug_Replace_Fix_num_2"

# Loop through all .als files in the folder
for filename in os.listdir(folder_path):
    if filename.endswith(".als"):
        # Set the path to the .als file
        file_path = os.path.join(folder_path, filename)

        # Set the path to the output file
        output_path = os.path.join(folder_path, filename.split(".")[0] + ".txt")

        # Run the Alloy analyzer and save the output to a text file
        with open(output_path, "w") as output_file:
            subprocess.run(["java", "-jar", alloy_jar_path, "-check", file_path], stdout=output_file)
