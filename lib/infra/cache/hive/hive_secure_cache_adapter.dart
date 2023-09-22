import 'dart:convert';

import 'package:ecommerce/data/cache/delete_secure_cache_storage.dart';
import 'package:ecommerce/data/cache/fetch_secure_cache_storage.dart';
import 'package:ecommerce/data/cache/save_secure_cache_storage.dart';
import 'package:ecommerce/data/cache/watch_secure_cache_storage.dart';
import 'package:ecommerce/infra/cache/exceptions/delete_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/fetch_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/key_not_found_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/save_cache_exception.dart';
import 'package:ecommerce/infra/cache/exceptions/watch_cache_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSecureCacheAdapter
    implements
        SaveSecureCacheStorage,
        DeleteSecureCacheStorage,
        FetchSecureCacheStorage,
        WatchSecureCacheStorage {
  final HiveInterface _hiveInterface;
  final FlutterSecureStorage _secureStorage;

  HiveSecureCacheAdapter(this._hiveInterface, this._secureStorage);

  // Private method to generate and store a new encryption key
  Future<void> _generateEncryptionKey(String encryptionKey) async {
    // Generate a new encryption key
    final generatedKey = _hiveInterface.generateSecureKey();

    // Encode the key to base64 and store it in secure storage
    await _secureStorage.write(
      key: encryptionKey,
      value: base64UrlEncode(generatedKey),
    );
  }

  // Private method to get encryption key from secure storage
  Future<String> _getEncryptionKey(String encryptionKey) async {
    // Read encryption key from secure storage
    final encryptionKeyString = await _secureStorage.read(key: encryptionKey);

    // If encryption key does not exist, generate a new one and store it
    if (encryptionKeyString == null) {
      await _generateEncryptionKey(encryptionKey);
    }

    // Read the encryption key from secure storage again
    final keySecure = await _secureStorage.read(key: encryptionKey);

    // If encryption key still does not exist, throw an exception
    if (keySecure == null) {
      throw KeyNotFoundException(encryptionKey);
    }

    return keySecure;
  }

  // Private method to get an encrypted lazy box
  Future<LazyBox<dynamic>> _getEncryptedLazyBox(
      String encryptionKey, String boxKey) async {
    // Get the encryption key from secure storage
    final encryptionKeyString = await _getEncryptionKey(encryptionKey);
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString);

    // Attempt to open the box with the given box key using the HiveInterface
    if (!Hive.isBoxOpen(boxKey)) {
      await _hiveInterface.openLazyBox(
        boxKey,
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
      );
    }

    // Get the encrypted lazy box
    final encryptedBox = _hiveInterface.lazyBox(boxKey);

    // Return the encrypted lazy box
    return encryptedBox;
  }

  @override
  Future<void> deleteByKey({
    required String boxKey,
    required String encryptionKey,
    required String key,
  }) async {
    final lazyBox = await _getEncryptedLazyBox(encryptionKey, boxKey);

    try {
      await lazyBox.delete(key);
      return;
    } catch (e) {
      throw DeleteCacheException('Failed to delete at key: $key');
    }
  }

  @override
  Future<void> put({
    required String encryptionKey,
    required String boxKey,
    required String key,
    required value,
  }) async {
    final lazyBox = await _getEncryptedLazyBox(encryptionKey, boxKey);

    try {
      await lazyBox.put(key, value);
    } catch (_) {
      throw SaveCacheException(
          'Failed to save data with key: $key -- value: $value');
    }
  }

  @override
  Future<void> putAll({
    required String encryptionKey,
    required String boxKey,
    required Map<String, dynamic> value,
  }) async {
    final lazyBox = await _getEncryptedLazyBox(encryptionKey, boxKey);

    try {
      await lazyBox.putAll(value);
    } catch (e) {
      throw SaveCacheException('Failed to save all data');
    }
  }

  @override
  Future<bool> containKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
  }) async {
    // Get the encrypted lazy box
    final lazyBox = await _getEncryptedLazyBox(encryptionKey, boxKey);

    try {
      // Check if the key exists in the box
      final containsKey = lazyBox.containsKey(key);
      return containsKey;
    } catch (_) {
      // Throw an exception if checking for the key fails
      throw FetchCacheException('Failed to check key: $key existed');
    }
  }

  @override
  Future<void> fetchByKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
  }) async {
    // Get the encrypted lazy box
    final lazyBox = await _getEncryptedLazyBox(encryptionKey, boxKey);

    try {
      // Get the value from the box
      final value = await lazyBox.get(key);
      return value;
    } catch (_) {
      // Throw an exception if fetching the value fails
      throw FetchCacheException('Failed to fetch by key: $key');
    }
  }

  @override
  Future<Stream<BoxEvent>> watchByKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
  }) async {
    // Get the encrypted lazy box
    final lazyBox = await _getEncryptedLazyBox(encryptionKey, boxKey);
    try {
      return lazyBox.watch(key: key);
    } catch (_) {
      // If there is an error, throw a custom WatchCacheException with an informative error message
      throw WatchCacheException('Failed to watch local data');
    }
  }
}
