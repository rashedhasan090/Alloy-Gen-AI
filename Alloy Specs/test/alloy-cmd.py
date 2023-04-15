import subprocess
import os
import sys

if len(sys.argv) < 2:
    print("Usage: python alloy-cmd.py <filename>")
    sys.exit(1)

filename = sys.argv[1]
commands = ["check", "show", "run"]

for command in commands:
    outputfile = f"{command}.txt"
    command_output = subprocess.check_output(["java", "-jar", "alloy4.jar", filename, command])
    with open(outputfile, "wb") as f:
        f.write(command_output)
