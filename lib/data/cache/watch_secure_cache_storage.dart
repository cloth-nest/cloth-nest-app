import 'package:hive_flutter/hive_flutter.dart';

abstract class WatchSecureCacheStorage {
  Future<Stream<BoxEvent>> watchByKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
  });
}
