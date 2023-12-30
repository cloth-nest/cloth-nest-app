import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Represents the accessibility presenter.
abstract class AccessibilityPresenter implements ChangeNotifier {
  RemoteMessage? get remoteMessage;
  NotificationResponse? get localMessage;

  // Reset remote message to null after tap notification successful.
  void resetRemoteMessage();
  void resetLocalMessage();
}
