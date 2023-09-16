import 'package:hive_flutter/hive_flutter.dart';

abstract class WatchCacheStorage {
  Future<Stream<BoxEvent>> watch({required String boxKey});

  Future<Stream<BoxEvent>> watchByKey({
    required String boxKey,
    required String key,
  });
}
