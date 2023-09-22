import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage makeSecureStorage() {
  const flutterSecureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  return flutterSecureStorage;
}
