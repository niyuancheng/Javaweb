package Function;
import java.io.UnsupportedEncodingException;

public class Main {
    private static final String APP_ID = "20210725000897424";
    private static final String SECURITY_KEY = "cjKHYoBaXBirH02_cWjp";

    public static void main(String[] args) throws UnsupportedEncodingException {
        Translate api = new Translate(APP_ID, SECURITY_KEY);

        String query = "Œ“œ≤ª∂≥‘ ∫";
        System.out.println(api.getTransResult(query, "auto", "en"));
    }
}
