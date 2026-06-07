package agou.eko.telegram.ui;

import org.telegram.ui.LaunchActivity;
import android.os.Bundle;

/**
 * AGOU Launch Activity
 *
 * Extends Telegram's LaunchActivity directly.
 * All login, registration by phone number, and navigation is handled
 * by the original Telegram code - we just rebrand.
 *
 * The user can:
 * ✅ Register with their phone number
 * ✅ Login to existing Telegram account
 * ✅ View stories
 * ✅ Chat with contacts
 * ✅ Full Telegram functionality
 *
 * @author @A_KOJO / AKRO
 */
public class LaunchActivity extends org.telegram.ui.LaunchActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // All initialization is handled by parent Telegram class
        // Our customization is in theme/colors only
    }
}
