import sys
from edu.mit.csail.sdg.alloy4whole import SimpleGUI

if __name__ == '__main__':
    # Check if the input file was provided
    if len(sys.argv) < 2:
        print("Usage: python alloy_runner.py input_file.als")
        sys.exit(1)

    # Get the input file path
    input_file = sys.argv[1]

    # Load the Alloy model
    try:
        model = SimpleGUI.loadXML(input_file)
    except Exception as e:
        print("Error: Failed to load the Alloy model:", e)
        sys.exit(1)

    # Run all the commands and get the outputs
    outputs = []
    for cmd in model.getAllCommands():
        output = cmd.execute()
        outputs.append(output)

    # Print the outputs
    for output in outputs:
        print(output)
