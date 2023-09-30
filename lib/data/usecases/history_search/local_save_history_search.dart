// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/cache/save_cache_storage.dart';
import 'package:ecommerce/data/usecases/history_search/constant.dart';
import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:ecommerce/domain/usecases/history_search/save_history_search.dart';

class LocalSaveHistorySearch implements SaveHistorySearch {
  final String boxKey;
  final SaveCacheStorage saveCacheStorage;

  LocalSaveHistorySearch({
    required this.boxKey,
    required this.saveCacheStorage,
  });

  @override
  Future<void> call(HistorySearchEntity entity) async {
    try {
      final model = entity.toModel();

      await saveCacheStorage.put(
        boxKey: boxKey,
        key: uniqueHistorySearchKey,
        value: model,
      );
    } catch (e) {
      rethrow;
    }
  }
}
