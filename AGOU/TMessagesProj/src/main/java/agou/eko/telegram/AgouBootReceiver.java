package agou.eko.telegram;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import org.telegram.messenger.ApplicationLoader;

/**
 * AGOU Boot Receiver
 * Restores notifications after device reboot
 */
public class AgouBootReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        ApplicationLoader.postInitApplication();
    }
}
