abstract class DeleteSecureCacheStorage {
  Future<void> deleteByKey({
    required String boxKey,
    required String encryptionKey,
    required String key,
  });
}
