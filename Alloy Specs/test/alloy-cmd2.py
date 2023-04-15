import edu.mit.csail.sdg.alloy4whole.SimpleGUI as SimpleGUI
import edu.mit.csail.sdg.alloy4.Err as Err
import java.io.File as File

def run_command(model, command):
    try:
        return SimpleGUI.runCommand(model, command)
    except Err as err:
        return str(err)

if __name__ == '__main__':
    filename = "arr1.als"
    commands = ["check", "show", "run"]

    with open(filename) as f:
        model = f.read()

    for command in commands:
        outputfile = f"{command}.txt"
        command_output = run_command(model, command)
        with open(outputfile, "w") as f:
            f.write(command_output)
