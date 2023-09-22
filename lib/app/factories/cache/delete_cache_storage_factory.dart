import 'package:ecommerce/app/factories/cache/secure_storage_factory.dart';
import 'package:ecommerce/data/cache/delete_cache_storage.dart';
import 'package:ecommerce/data/cache/delete_secure_cache_storage.dart';
import 'package:ecommerce/infra/cache/hive/hive_cache_adapter.dart';
import 'package:ecommerce/infra/cache/hive/hive_secure_cache_adapter.dart';
import 'package:hive/hive.dart';

DeleteSecureCacheStorage makeDeleteSecureCacheStorage() {
  final flutterSecureStorage = makeSecureStorage();
  return HiveSecureCacheAdapter(
    Hive,
    flutterSecureStorage,
  );
}

DeleteCacheStorage makeDeleteCacheStorage() {
  return HiveCacheAdapter(Hive);
}
