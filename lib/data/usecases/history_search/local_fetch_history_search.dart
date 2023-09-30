// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/cache/fetch_cache_storage.dart';
import 'package:ecommerce/data/models/history_search/history_search_model.dart';
import 'package:ecommerce/data/usecases/history_search/constant.dart';
import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:ecommerce/domain/usecases/history_search/fetch_history_search.dart';

class LocalFetchHistorySearch implements FetchHistorySearch {
  final String boxKey;
  final FetchCacheStorage fetchCacheStorage;

  LocalFetchHistorySearch({
    required this.boxKey,
    required this.fetchCacheStorage,
  });

  @override
  Future<HistorySearchEntity?> call() async {
    try {
      final model = await fetchCacheStorage.fetchByKey(
        boxKey: boxKey,
        key: uniqueHistorySearchKey,
      );
      if (model is HistorySearchModel) {
        final entity = model.toEntity();
        return entity;
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }
}
