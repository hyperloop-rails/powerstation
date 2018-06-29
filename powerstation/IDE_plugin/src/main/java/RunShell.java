import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class RunShell {
    
    public static void main(final String[] args) throws IOException, InterruptedException {
        //runCommand("b1", "/home/junwen/research/Code/blog/", "./static-analyzer/");
    }
    // app is the name of the application
    // input is the absolute path of the application
    // analysis is absolute path of this repo
    public static void runCommand(String analysis, String command) throws IOException, InterruptedException {
        //Build command
        List<String> commands = new ArrayList<String>();
        //commands.add("echo test;");
        for (String c: command.split(" ")){
            commands.add(c);
        }
        //Add arguments
        System.out.println("command is " + commands);
        //Run macro on target
        ProcessBuilder pb = new ProcessBuilder(commands);
        pb.directory(new File(analysis));
        System.out.println("pb directory is :" + pb.directory());
        pb.redirectErrorStream(true);
        Process process = pb.start();
        //Read output
        StringBuilder out = new StringBuilder();
        BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line = null, previous = null;
        while ((line = br.readLine()) != null)
            if (!line.equals(previous)) {
                previous = line;
                out.append(line).append('\n');
                System.out.println(line);
            }

        //Check result
        if (process.waitFor() == 0) {
            System.out.println("Success!");
            //System.exit(0);
        }

        //Abnormal termination: Log command parameters and output and throw ExecutionException
        System.err.println(commands);
        System.err.println(out.toString());
        //System.exit(1);
    }
    
}
