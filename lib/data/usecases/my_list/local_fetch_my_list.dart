import 'package:ecommerce/data/cache/fetch_cache_storage.dart';
import 'package:ecommerce/data/models/my_list/my_list_model.dart';
import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';
import 'package:ecommerce/domain/usecases/my_list/fetch_my_list.dart';

class LocalFetchMyList implements FetchMyList {
  final String boxKey;
  final FetchCacheStorage fetchCacheStorage;

  LocalFetchMyList({
    required this.boxKey,
    required this.fetchCacheStorage,
  });

  @override
  Future<List<MyListEntity>> call() async {
    List<MyListEntity> result = [];
    try {
      List<dynamic> listResultHive = await fetchCacheStorage.fetchAll(
        boxKey: boxKey,
      );

      for (final element in listResultHive) {
        result.add((element as MyListModel).toEntity());
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
