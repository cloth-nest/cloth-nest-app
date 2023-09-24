abstract class FetchSecureCacheStorage {
  Future fetchByKey({
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
