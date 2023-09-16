abstract class SaveSecureCacheStorage {
  Future<void> put({
    required String encryptionKey,
    required String boxKey,
    required String key,
    required dynamic value,
  });

  Future<void> putAll({
    required String encryptionKey,
    required String boxKey,
    required Map<String, dynamic> value,
  });
}
