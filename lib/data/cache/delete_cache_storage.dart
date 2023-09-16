abstract class DeleteCacheStorage {
  Future<void> deleteByKey({required String boxKey, required String key});

  Future<void> deleteAll({required String boxKey});
}
