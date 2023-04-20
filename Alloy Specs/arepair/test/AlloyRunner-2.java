import edu.mit.csail.sdg.alloy4whole.SimpleGUI;
import edu.mit.csail.sdg.alloy4whole.SimpleReporter;
import java.io.FileWriter;
import java.util.List;

public class AlloyRunner {
    public static void main(String[] args) {
        // Check if the input file extension was provided
        if (args.length < 1) {
            System.out.println("Usage: java AlloyRunner input_file_extension");
            System.exit(1);
        }

        // Get the input file extension
        String inputExtension = args[0];

        // Find all the Alloy files with the given extension
        File inputFolder = new File(".");
        File[] inputFiles = inputFolder.listFiles((dir, name) -> name.toLowerCase().endsWith(inputExtension));
        if (inputFiles == null || inputFiles.length == 0) {
            System.out.println("Error: No input files found with extension " + inputExtension);
            System.exit(1);
        }

        // Load each Alloy model, run all the commands, and save the outputs
        SimpleGUI gui = new SimpleGUI(false);
        for (File inputFile : inputFiles) {
            try {
                gui.loadXML(inputFile.getAbsolutePath());
            } catch (Exception e) {
                System.out.println("Error: Failed to load the Alloy model " + inputFile.getName() + ": " + e.getMessage());
                continue;
            }

            List<SimpleReporter.SimpleReport> reports = gui.getAllReports();
            for (int i = 0; i < reports.size(); i++) {
                SimpleReporter.SimpleReport report = reports.get(i);
                List<String> output = report.getResults();

                String outputFilePath = inputFile.getName() + "_" + (i+1) + ".txt";
                try (FileWriter writer = new FileWriter(outputFilePath)) {
                    for (String line : output) {
                        writer.write(line);
                        writer.write(System.lineSeparator());
                    }
                } catch (IOException e) {
                    System.out.println("Error: Failed to save the output of command " + (i+1) + " of " + inputFile.getName() + " to " + outputFilePath + ": " + e.getMessage());
                }
            }
        }
    }
}
