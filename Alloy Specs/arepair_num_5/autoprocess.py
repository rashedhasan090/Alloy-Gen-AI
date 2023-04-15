import subprocess

# path to the Alloy Analyzer jar file
ALLOY_JAR_PATH = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_5/alloy4.2.jar"

# path to the Alloy file to evaluate
ALLOY_FILE_PATH = "/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_5/balancedBST2_1.als"

# command to call the Alloy Analyzer jar file and evaluate the Alloy file
command = ["java", "-jar", ALLOY_JAR_PATH, "--check", ALLOY_FILE_PATH, "--run"]

# call the command and capture the output
output = subprocess.check_output(command, universal_newlines=True)

# print the output
print(output)

# write the output to a text file
with open("balancedBST2_1.txt", "w") as f:
    f.write(output)
