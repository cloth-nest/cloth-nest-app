import 'package:ecommerce/app/protocols/permission.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class PermissionAdapter implements Permission {
  PermissionAdapter();

  @override
  Future<permission.PermissionStatus> fetchNotificationPermission() async {
    final status = await permission.Permission.notification.status;
    return status;
  }

  @override
  Future<void> requestNotificationPermission() async {
    var status = await permission.Permission.notification.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before.
      status = await permission.Permission.notification.request();
    }
  }

  @override
  Future openSettings() {
    return permission.openAppSettings();
  }
}
