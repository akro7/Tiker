package agou.eko.telegram;

import android.app.Application;
import android.content.Context;

import org.telegram.messenger.ApplicationLoader;

/**
 * AGOU Application Class
 *
 * Based on Telegram Open Source (https://github.com/DrKLO/Telegram)
 * Modified by @A_KOJO / AKRO
 *
 * This class extends Telegram's ApplicationLoader to:
 * - Set app name to "AGOU"
 * - Use package agou.eko.telegram
 * - Register with Telegram servers using your API ID/Hash
 */
public class AgouApp extends ApplicationLoader {

    // ─── App Identity ─────────────────────────────────────────────────────────
    public static final String APP_NAME        = "AGOU";
    public static final String APP_VERSION     = "1.0.0";
    public static final String DEVELOPER       = "@A_KOJO";
    public static final String BRAND           = "AKRO";

    // ─── Telegram API (اطلبهم من https://my.telegram.org/apps) ───────────────
    // !! مهم: لازم تسجل على my.telegram.org وتاخد APP_ID و APP_HASH خاصين بيك !!
    public static final int    TELEGRAM_APP_ID   = BuildConfig.APP_ID;
    public static final String TELEGRAM_APP_HASH = BuildConfig.APP_HASH;

    private static AgouApp instance;

    @Override
    public void onCreate() {
        instance = this;
        super.onCreate();
        // Additional AGOU initialization
        AgouConfig.init(this);
    }

    public static AgouApp getInstance() {
        return instance;
    }

    @Override
    protected String getApplicationName() {
        return APP_NAME;
    }
}
