import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseMessageObserver {
  void onMessageReceived(RemoteMessage message);
  void onMessageOpenedApp(RemoteMessage message);
}
