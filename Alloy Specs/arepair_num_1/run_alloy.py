import subprocess

jar_path = '/Users/rashedhasan/Downloads/alloy4.2_2015-02-22.jar'
als_path = '/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_1/addr1.als'
output_path = '/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_1/outputaddr1.txt'

# Construct the command to run the Alloy Jar file
command = ['java', '-jar', jar_path, als_path]

# Run the command and capture the output
result = subprocess.run(command, stdout=subprocess.PIPE).stdout.decode()

# Write the output to a text file
with open(output_path, 'w') as file:
    file.write(result)
