package agou.eko.telegram;

import org.telegram.messenger.ApplicationLoader;
import org.telegram.messenger.BuildVars;

/**
 * AGOU Application Class
 * @author @A_KOJO / AKRO
 */
public class AgouApp extends ApplicationLoader {

    public static final String APP_NAME    = "AGOU";
    public static final String APP_VERSION = "1.0.0";
    public static final String DEVELOPER   = "@A_KOJO";

    private static AgouApp instance;

    @Override
    public void onCreate() {
        instance = this;
        super.onCreate();
        AgouConfig.init(this);
    }

    public static AgouApp getInstance() {
        return instance;
    }
}
