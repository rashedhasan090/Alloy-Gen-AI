import edu.mit.csail.sdg.alloy4.*;
import edu.mit.csail.sdg.alloy4compiler.ast.*;
import edu.mit.csail.sdg.alloy4compiler.parser.*;
import edu.mit.csail.sdg.alloy4compiler.translator.*;



import java.io.*;
import java.util.List;

public class AlloyRunner {

    public static void main(String[] args) throws Err, IOException {
        // Check if the file name is provided as argument
        if (args.length != 1) {
            System.out.println("Usage: java AlloyRunner <filename>");
            return;
        }

        String fileName = args[0];
        File file = new File(fileName);

        // Check if the file exists
        if (!file.exists()) {
            System.out.println("File " + fileName + " does not exist!");
            return;
        }

        // Check if the file extension is ".als"
        if (!fileName.endsWith(".als")) {
            System.out.println("File " + fileName + " is not an Alloy file (.als)!");
            return;
        }

        // Compile the Alloy file using the Alloy Compile API
        System.out.println("Compiling " + fileName + "...");
        CompUtil.initOriginalYicesPath(null);
        CompModule module = CompUtil.parseEverything_fromFile(null, null, fileName);

        // Run all the commands and save the output to separate files
        List<Command> commands = module.getAllCommands();
        for (Command command : commands) {
            String commandName = command.toString().replaceAll("[^a-zA-Z0-9.-]", "_");
            System.out.println("Running command: " + commandName);
            A4Solution solution = TranslateAlloyToKodkod.execute_command(null, module.getAllReachableSigs(), command, null);
            String output = solution.toString();
            String outputFileName = commandName + ".txt";
            System.out.println("Saving output to file: " + outputFileName);
            writeToFile(outputFileName, output);
        }

        System.out.println("All commands completed successfully.");
    }

    private static void writeToFile(String fileName, String content) throws IOException {
        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
        writer.write(content);
        writer.close();
    }

}
