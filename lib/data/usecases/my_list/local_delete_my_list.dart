// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/cache/delete_cache_storage.dart';
import 'package:ecommerce/domain/usecases/my_list/delete_my_list.dart';

class LocalDeleteMyList implements DeleteMyList {
  final String boxKey;
  final DeleteCacheStorage deleteCacheStorage;

  LocalDeleteMyList({
    required this.boxKey,
    required this.deleteCacheStorage,
  });

  @override
  Future<void> call({required String key}) async {
    try {
      await deleteCacheStorage.deleteByKey(
        boxKey: boxKey,
        key: key,
      );
    } catch (e) {
      rethrow;
    }
  }
}
