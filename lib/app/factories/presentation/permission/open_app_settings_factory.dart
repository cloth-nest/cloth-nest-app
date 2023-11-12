import 'package:ecommerce/app/factories/permission/permission_factory.dart';

Future<void> openAppSettings() async {
  final openAppSettings = makeOpenSettings();
  return openAppSettings.openSettings();
}
