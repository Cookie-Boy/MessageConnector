import java.io.File;
import java.io.IOException;

public class StaticProcess {
    public static void runInBackground(String directory, String scriptPath) throws IOException {
        ProcessBuilder builder = new ProcessBuilder("bash", "-c", scriptPath);
        builder.directory(new File(directory));
        builder.redirectOutput(ProcessBuilder.Redirect.INHERIT);
        builder.redirectError(ProcessBuilder.Redirect.INHERIT);
        builder.start();
    }
}
