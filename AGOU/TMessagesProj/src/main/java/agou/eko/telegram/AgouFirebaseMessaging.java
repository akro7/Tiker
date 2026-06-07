package agou.eko.telegram;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import org.telegram.messenger.PushListenerController;

/**
 * AGOU Firebase Messaging Service
 * Handles push notifications - delegates to Telegram's system
 */
public class AgouFirebaseMessaging extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Delegate to Telegram's push handler
        PushListenerController.processRemoteMessage(remoteMessage);
    }

    @Override
    public void onNewToken(String token) {
        // Telegram handles token registration automatically
        PushListenerController.onTokenReceived(token,
            PushListenerController.PUSH_TYPE_FIREBASE);
    }
}
