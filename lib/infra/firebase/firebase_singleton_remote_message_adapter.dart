import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/app/protocols/firebase.dart';
import 'package:ecommerce/infra/firebase/firebase_message_subject.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// A class that handles remote notifications from Firebase and local notifications using `FlutterLocalNotificationsPlugin`.
class FirebaseSingletonRemoteMessageAdapter {
  static final FirebaseSingletonRemoteMessageAdapter _instance =
      FirebaseSingletonRemoteMessageAdapter._internal(
    firebaseMessaging: FirebaseMessaging.instance,
    subject: FirebaseMessageSubject(),
  );

  factory FirebaseSingletonRemoteMessageAdapter() {
    return _instance;
  }

  FirebaseSingletonRemoteMessageAdapter._internal({
    required FirebaseMessaging firebaseMessaging,
    required FirebaseMessageSubject subject,
  })  : _firebaseMessaging = firebaseMessaging,
        _subject = subject;

  final FirebaseMessaging _firebaseMessaging;

  final FirebaseMessageSubject _subject;

  // ------------------------------
  // Firebase Messaging methods
  // ------------------------------

  Future<void> initPushNotification() async {
    await listenToMessageOnAppOpened();

    await listenToMessage();
  }

  Future<void> saveToken({required String email}) async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .set({'token': fcmToken});
    } catch (e) {
      debugPrint('save token error: $e');
    }
  }

  Future<NotificationSettings> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      /// Enables an alert for the notification.
      alert: true,

      /// Enables an announcement for the notification.
      announcement: true,

      /// Enables a badge for the notification.
      badge: false,

      /// Enables CarPlay for the notification.
      carPlay: true,

      /// Enables a critical alert for the notification.
      criticalAlert: true,

      ///Enables a provisional notification.
      provisional: true,

      /// Enables a sound for the notification.
      sound: true,
    );
    return settings;
  }

  /// Subscribes to a Firebase topic.
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  /// Unsubscribes from a Firebase topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  /// Deletes the Firebase Cloud Messaging token.
  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<String?> getFCMToken(String gmail) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('Users').doc(gmail).get();

      if (doc.data() == null) {
        return '';
      }

      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      String fcmToken = data['token'];

      return fcmToken;
    } catch (e) {
      debugPrint('getFCMToken error: $e');
      return null;
    }
  }

  /// Listens for new messages.
  Future<void> listenToMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /// Notifies observers that a new message was received.
      _subject.notifyMessageReceived(message);

      /// Handles the received message.
      handleMessage(message);
    });
  }

  /// Listens for background messages.
  Future<void> listenBackgroundToMessage(RemoteMessage message) async {
    /// Notifies observers that a message was received in the background.
    _subject.notifyMessageReceived(message);
  }

  /// Handles incoming messages.
  Future<void> handleMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
  }

  Future<void> listenToMessageOnAppOpened() async {
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOnOpenedApp);
  }

  /// Gets the initial message when the app is opened from a notification.
  Future<RemoteMessage?> getInitialMessage() async {
    final message = await _firebaseMessaging.getInitialMessage();
    return message;
  }

  /// Get the Firebase Cloud Messaging token.
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Listen for token refresh events.
  Future<void> onTokenRefresh(Function(String) handler) async {
    _firebaseMessaging.onTokenRefresh.listen(handler);
  }

  /// Handles the app being opened from a notification.
  Future<void> handleMessageOnOpenedApp(RemoteMessage message) async {
    /// Notifies observers that a message opened the app.
    _subject.notifyMessageOpenedApp(message);

    /// Prints details about the message for debugging.
    if (kDebugMode) {
      debugPrint('handleMessageOpenedApp');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
      debugPrint('Payload: ${message.data}');
    }
  }

  /// Attaches an observer to message events.
  void subscribeObserver(FirebaseMessageObserver observer) {
    _subject.subscribe(observer);
  }

  /// Detaches an observer from message events.
  void unsubscribeObserver(FirebaseMessageObserver observer) {
    _subject.unsubscribe(observer);
  }
}
