import 'package:ecommerce/app/protocols/firebase.dart';
import 'package:ecommerce/infra/local_notification/flutter_local_notification_adapter.dart';
import 'package:ecommerce/presentation/presenters/accessibility/accessibility_presenter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications_platform_interface/src/types.dart';

class ProviderAccessibilityPresenter
    with ChangeNotifier
    implements
        AccessibilityPresenter,
        FirebaseMessageObserver,
        LocalNotificationObserver {
  RemoteMessage? _remoteMessage;
  NotificationResponse? _notificationResponse;

  @override
  void onMessageOpenedApp(RemoteMessage message) {
    _remoteMessage = message;
    notifyListeners();
  }

  @override
  void onMessageReceived(RemoteMessage message) {
    FlutterSingletonLocalNotificationAdapter().showNotification(
      id: 1,
      title: message.notification?.title,
      body: message.notification?.body,
      payload: message.data['screen'],
    );
    debugPrint(message.from);
  }

  @override
  RemoteMessage? get remoteMessage => _remoteMessage;

  @override
  void resetRemoteMessage() {
    _remoteMessage = null;
    notifyListeners();
  }

  @override
  void onSelectLocalNotification(NotificationResponse details) {
    _notificationResponse = details;
    notifyListeners();
  }

  @override
  NotificationResponse? get localMessage => _notificationResponse;

  @override
  void resetLocalMessage() {
    _notificationResponse = null;
    notifyListeners();
  }
}
