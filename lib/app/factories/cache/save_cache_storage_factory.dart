import 'package:ecommerce/app/factories/cache/secure_storage_factory.dart';
import 'package:ecommerce/data/cache/save_cache_storage.dart';
import 'package:ecommerce/data/cache/save_secure_cache_storage.dart';

import 'package:ecommerce/infra/cache/hive/hive_cache_adapter.dart';
import 'package:ecommerce/infra/cache/hive/hive_secure_cache_adapter.dart';
import 'package:hive/hive.dart';

SaveSecureCacheStorage makeSaveSecureCacheStorage() {
  final flutterSecureStorage = makeSecureStorage();
  return HiveSecureCacheAdapter(
    Hive,
    flutterSecureStorage,
  );
}

SaveCacheStorage makeSaveCacheStorage() {
  return HiveCacheAdapter(Hive);
}
