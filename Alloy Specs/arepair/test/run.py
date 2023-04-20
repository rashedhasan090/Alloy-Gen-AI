import os
from edu.mit.csail.sdg.alloy4compiler.translator import TranslateAlloyToKodkod
from edu.mit.csail.sdg.alloy4compiler.parser import AlloyParser
from edu.mit.csail.sdg.alloy4compiler.ast import Command

def run_alloy_file(file_path):
    # Check if the file extension is ".als"
    if not file_path.endswith('.als'):
        print(f'Error: {file_path} is not an Alloy file (.als)!')
        return

    # Check if the file exists
    if not os.path.exists(file_path):
        print(f'Error: File {file_path} does not exist!')
        return

    # Compile the Alloy file using the Alloy API
    alloy_parser = AlloyParser()
    model = alloy_parser.parse_from_file(file_path)

    # Run all the commands and save the output to separate files
    for cmd in model.getAllCommands():
        command_name = cmd.label.replace(' ', '_').replace('/', '_')
        solution = TranslateAlloyToKodkod.execute_command(model.getAllReachableSigs(), cmd, solver='kodkod')
        output_file = open(f'{command_name}.txt', 'w')
        output_file.write(str(solution))
        output_file.close()
        print(f'Output saved to {command_name}.txt')

    print('All commands completed successfully.')

if __name__ == '__main__':
    # Get the file path from the user
    file_path = input('Enter the path of the Alloy file: ')

    run_alloy_file(file_path)
