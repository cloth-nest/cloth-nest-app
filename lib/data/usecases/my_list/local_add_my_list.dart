// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/cache/save_cache_storage.dart';
import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';
import 'package:ecommerce/domain/usecases/my_list/add_my_list.dart';

class LocalAddMyList implements AddMyList {
  final String boxKey;
  final SaveCacheStorage saveCacheStorage;
  LocalAddMyList({
    required this.boxKey,
    required this.saveCacheStorage,
  });

  @override
  Future<void> call({required MyListEntity entity}) async {
    try {
      await saveCacheStorage.put(
        boxKey: boxKey,
        key: entity.id,
        value: entity.toModel(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
