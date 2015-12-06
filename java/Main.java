import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.io.FileReader;
import java.util.Scanner;
import java.util.concurrent.Executors;
import java.util.function.Consumer;

public class Main {

    public static void main(String[] args) throws Exception {
        ScriptEngine scriptEngine = new ScriptEngineManager().getEngineByName("nashorn");
        Executors.newSingleThreadExecutor().execute(new Runnable() {
            @Override
            public void run() {
                try (Scanner scanner = new Scanner(System.in)) {
                    while (scanner.hasNextLine()) {
                        String line = scanner.nextLine();
                        handler.accept(line);
                    }
                }
            }
        });
        scriptEngine.eval(new FileReader("context.js"));
        scriptEngine.eval(new FileReader("app.js"));
    }

    public static void display(String message) {
        System.out.println(message);
    }

    public static void onInput(Consumer<String> handler) {
        Main.handler = handler;
    }

    private static Consumer<String> handler;
}
