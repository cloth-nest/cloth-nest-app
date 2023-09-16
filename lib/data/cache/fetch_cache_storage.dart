abstract class FetchCacheStorage {
  Future<dynamic> fetchByKey({required String boxKey, required String key});

  Future<dynamic> fetchAll({required String boxKey});

  Future<bool> containKey({required String boxKey, required String key});
}
