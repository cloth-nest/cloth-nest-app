import 'package:ecommerce/app/factories/cache/secure_storage_factory.dart';
import 'package:ecommerce/data/cache/fetch_cache_storage.dart';
import 'package:ecommerce/data/cache/fetch_secure_cache_storage.dart';
import 'package:ecommerce/infra/cache/hive/hive_cache_adapter.dart';
import 'package:ecommerce/infra/cache/hive/hive_secure_cache_adapter.dart';
import 'package:hive/hive.dart';

FetchSecureCacheStorage makeFetchSecureCacheStorage() {
  final flutterSecureStorage = makeSecureStorage();
  return HiveSecureCacheAdapter(
    Hive,
    flutterSecureStorage,
  );
}

FetchCacheStorage makeFetchCacheStorage() {
  return HiveCacheAdapter(Hive);
}
