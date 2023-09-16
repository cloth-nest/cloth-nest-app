abstract class UpdateSecureCacheStorage {
  Future<dynamic> updateByKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
    required dynamic value,
  });
}
