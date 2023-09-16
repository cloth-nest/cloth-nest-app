abstract class FetchSecureCacheStorage {
  Future<void> fetchByKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
  });

  Future<bool> containKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
  });
}
