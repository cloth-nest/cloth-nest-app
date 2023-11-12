import 'package:permission_handler/permission_handler.dart';

abstract class NotificationPermission {
  Future<PermissionStatus> fetchNotificationPermission();

  Future<void> requestNotificationPermission();
}

abstract class OpenSettings {
  Future openSettings();
}

abstract class Permission implements NotificationPermission, OpenSettings {}
