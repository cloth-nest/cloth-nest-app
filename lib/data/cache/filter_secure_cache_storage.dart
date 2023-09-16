abstract class FilterSecureCacheStorage {
  Future<Iterable<dynamic>> filterByKey({
    required String encryptionKey,
    required String boxKey,
    required String key,
    required bool Function(dynamic event) callback,
  });
}
