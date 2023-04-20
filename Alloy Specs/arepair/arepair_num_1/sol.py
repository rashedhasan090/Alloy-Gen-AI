import os
import subprocess

# path to the Alloy 4.2 jar file
alloy_jar = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_1/alloy4.2.jar"

# directory containing Alloy files to analyze
directory = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_1"

# loop through all files in the directory with .als extension
for filename in os.listdir(directory):
    if filename.endswith(".als"):
        # run the Alloy Analyzer on the file
        input_file = os.path.join(directory, filename)
        output_file = os.path.splitext(input_file)[0] + ".txt"
        subprocess.run(["java", "-jar", alloy_jar, "-m2", input_file, "--output-to-file", output_file], check=True)
