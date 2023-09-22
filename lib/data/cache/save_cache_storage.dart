abstract class SaveCacheStorage {
  Future<void> put({
    required String boxKey,
    required String key,
    required dynamic value,
  });

  Future<void> putAll(
      {required String boxKey, required Map<String, dynamic> value});
}
