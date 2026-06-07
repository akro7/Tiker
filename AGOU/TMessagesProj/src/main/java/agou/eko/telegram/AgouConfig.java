package agou.eko.telegram;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * AGOU Central Configuration
 * Controls all app-level settings and customizations
 *
 * @author @A_KOJO / AKRO
 */
public class AgouConfig {

    private static final String PREFS_NAME = "agou_config";

    // ─── App Branding ─────────────────────────────────────────────────────────
    public static final String APP_NAME         = "AGOU";
    public static final String APP_PACKAGE      = "agou.eko.telegram";
    public static final String APP_VERSION      = "1.0.0";
    public static final String DEVELOPER        = "@A_KOJO";
    public static final String SUPPORT_USERNAME = "A_KOJO";   // تيليجرام سابورت

    // ─── Theme Colors (AGOU Dark Blue Theme) ──────────────────────────────────
    // Primary accent - electric cyan
    public static final int COLOR_PRIMARY        = 0xFF00D4FF;
    // Darker accent
    public static final int COLOR_PRIMARY_DARK   = 0xFF0099E6;
    // Background dark
    public static final int COLOR_BACKGROUND     = 0xFF0A0E1A;
    // Card/surface color
    public static final int COLOR_SURFACE        = 0xFF0D1F3C;
    // Text primary
    public static final int COLOR_TEXT           = 0xFFFFFFFF;
    // Text secondary
    public static final int COLOR_TEXT_SECONDARY = 0xFFB0BEC5;
    // Message bubble outgoing
    public static final int COLOR_BUBBLE_OUT     = 0xFF1A3A5C;
    // Message bubble incoming
    public static final int COLOR_BUBBLE_IN      = 0xFF0D1F3C;

    // ─── Feature Flags ────────────────────────────────────────────────────────
    public static boolean SHOW_AGOU_BADGE    = true;   // "AGOU" badge في الـ about
    public static boolean HIDE_PHONE_NUMBER  = false;  // إخفاء رقم الهاتف
    public static boolean GHOST_MODE         = false;  // وضع Ghost (قراءة بدون علامة)
    public static boolean CUSTOM_FONT        = true;   // فونت مخصص

    private static SharedPreferences prefs;

    public static void init(Context context) {
        prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        loadSettings();
    }

    private static void loadSettings() {
        if (prefs == null) return;
        GHOST_MODE       = prefs.getBoolean("ghost_mode", false);
        HIDE_PHONE_NUMBER = prefs.getBoolean("hide_phone", false);
        SHOW_AGOU_BADGE  = prefs.getBoolean("show_badge", true);
    }

    public static void setGhostMode(boolean enabled) {
        GHOST_MODE = enabled;
        if (prefs != null)
            prefs.edit().putBoolean("ghost_mode", enabled).apply();
    }

    public static void setHidePhone(boolean enabled) {
        HIDE_PHONE_NUMBER = enabled;
        if (prefs != null)
            prefs.edit().putBoolean("hide_phone", enabled).apply();
    }
}
