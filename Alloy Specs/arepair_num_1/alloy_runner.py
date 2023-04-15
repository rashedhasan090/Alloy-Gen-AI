import sys
import os
from edu.mit.csail.sdg.alloy4whole import SimpleGUI
from edu.mit.csail.sdg.alloy4compiler.parser import CompUtil
from edu.mit.csail.sdg.alloy4compiler.translator import TranslateAlloyToKodkod

# Check if a file path was provided as argument
if len(sys.argv) != 2:
    print("Usage: python alloy_runner.py file_path.als")
    sys.exit(1)

file_path = sys.argv[1]

# Check if the file exists
if not os.path.isfile(file_path):
    print("File not found.")
    sys.exit(1)

# Load the Alloy specification
model = CompUtil.loadModelFromFile(None, file_path)

# Translate the Alloy specification to Kodkod
options = TranslateAlloyToKodkod.getOptions()
options.solver = "MiniSatProverJNI"
kkresult = TranslateAlloyToKodkod.execute_command(None, model.getAllCommands(), options)

# Save the output in a text file
with open("output.txt", "w") as f:
    f.write(str(kkresult))

print("Output saved in output.txt")
