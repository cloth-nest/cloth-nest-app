import 'package:ecommerce/data/cache/delete_cache_storage.dart';
import 'package:ecommerce/data/cache/fetch_cache_storage.dart';
import 'package:ecommerce/data/cache/save_cache_storage.dart';
import 'package:ecommerce/data/cache/watch_cache_storage.dart';
import 'package:ecommerce/infra/cache/exceptions/delete_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/fetch_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/not_found_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/save_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/watch_cache_exception.dart';
import 'package:hive/hive.dart';

class HiveCacheAdapter
    implements
        SaveCacheStorage,
        FetchCacheStorage,
        DeleteCacheStorage,
        WatchCacheStorage {
  // The HiveInterface instance to interact with the Hive database
  final HiveInterface _hiveInterface;

  // Constructor to initialize the HiveCacheAdapter with the HiveInterface instance
  const HiveCacheAdapter(this._hiveInterface);

  Future<LazyBox> _getOrCreateLazyBox(String boxKey) async {
    return _hiveInterface.openLazyBox(boxKey);
  }

  @override
  Future<bool> containKey({required String boxKey, required String key}) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);
    try {
      return lazyBox.containsKey(key);
    } catch (e) {
      throw NotFoundCacheException('Failed to find key');
    }
  }

  @override
  Future<void> deleteAll({required String boxKey}) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      await lazyBox.deleteAll(lazyBox.keys);
      return;
    } catch (_) {
      throw DeleteCacheException('Failed to delete all');
    }
  }

  @override
  Future<void> deleteByKey({
    required String boxKey,
    required String key,
  }) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      await lazyBox.delete(key);
    } catch (e) {
      throw DeleteCacheException('Failed to delete at key: $key');
    }
  }

  @override
  Future fetchAll({required String boxKey}) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      final keys = lazyBox.keys;
      final list = <dynamic>[];

      for (var key in keys) {
        dynamic value = await lazyBox.get(key);
        list.add(value);
      }

      return list;
    } catch (e) {
      throw FetchCacheException('Failed to fetch all');
    }
  }

  @override
  Future fetchByKey({required String boxKey, required String key}) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      return await lazyBox.get(key);
    } catch (e) {
      throw FetchCacheException('Failed to fetch by key: $key');
    }
  }

  @override
  Future<void> put({
    required String boxKey,
    required String key,
    required value,
  }) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      return await lazyBox.put(key, value);
    } catch (_) {
      throw SaveCacheException('Failed to save key: $key -- value: $value');
    }
  }

  @override
  Future<void> putAll({
    required String boxKey,
    required Map<String, dynamic> value,
  }) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      await lazyBox.putAll(value);
    } catch (e) {
      throw SaveCacheException('Failed to save all data');
    }
  }

  @override
  Future<Stream<BoxEvent>> watch({required String boxKey}) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      return lazyBox.watch(key: boxKey);
    } catch (e) {
      throw WatchCacheException('Failed to watch by box key: $boxKey');
    }
  }

  @override
  Future<Stream<BoxEvent>> watchByKey({
    required String boxKey,
    required String key,
  }) async {
    final lazyBox = await _getOrCreateLazyBox(boxKey);

    try {
      return lazyBox.watch(key: key);
    } catch (e) {
      throw WatchCacheException('Failed to watch by key: $key');
    }
  }
}
