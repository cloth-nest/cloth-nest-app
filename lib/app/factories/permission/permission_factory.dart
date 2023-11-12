import 'package:ecommerce/app/protocols/permission.dart';
import 'package:ecommerce/infra/permission/permission_adapter.dart';

NotificationPermission makeNotificationPermission() {
  return PermissionAdapter();
}

OpenSettings makeOpenSettings() {
  return PermissionAdapter();
}
