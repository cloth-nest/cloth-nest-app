import 'package:ecommerce/app/factories/cache/secure_storage_factory.dart';
import 'package:ecommerce/data/cache/watch_cache_storage.dart';
import 'package:ecommerce/data/cache/watch_secure_cache_storage.dart';
import 'package:ecommerce/infra/cache/hive/hive_cache_adapter.dart';
import 'package:ecommerce/infra/cache/hive/hive_secure_cache_adapter.dart';
import 'package:hive/hive.dart';

WatchSecureCacheStorage makeWatchSecureCacheStorage() {
  final flutterSecureStorage = makeSecureStorage();
  return HiveSecureCacheAdapter(
    Hive,
    flutterSecureStorage,
  );
}

WatchCacheStorage makeWatchCacheStorage() {
  return HiveCacheAdapter(Hive);
}
