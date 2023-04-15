import sys
sys.path.append('/Users/rashedhasan/Downloads/alloy4.2_2015-02-22.jar')  # replace with the actual path to the Alloy jar file

from edu.mit.csail.sdg.alloy4compiler.parser import CompUtil
from edu.mit.csail.sdg.alloy4compiler.translator import TranslateAlloyToKodkod
from edu.mit.csail.sdg.alloy4whole import SimpleGUI

# Load the model from an Alloy specification file
model = CompUtil.loadModelFromFile(None, '/Users/rashedhasan/Downloads/atmprep-master/benchmark/arepair_num_1/addr1.als')

# Set the options for the Alloy translator
options = TranslateAlloyToKodkod.getOptions()
options.solver = 'MiniSatProverJNI'

# Execute an Alloy command and get the result
command = model.getAllCommands()[0]  # get the first command in the model
result = TranslateAlloyToKodkod.execute_command(None, command, options)

# Print the result
print(result)
