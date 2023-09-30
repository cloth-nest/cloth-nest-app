import 'package:ecommerce/app/factories/cache/fetch_cache_storage.factory.dart';
import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/history_search/local_fetch_history_search.dart';
import 'package:ecommerce/data/usecases/history_search/local_save_history_search.dart';
import 'package:ecommerce/domain/usecases/history_search/fetch_history_search.dart';
import 'package:ecommerce/domain/usecases/history_search/save_history_search.dart';

String boxKey = 'BOX_KEY_HISTORY_SEARCH';

SaveHistorySearch makeSaveHistorySearch() {
  return LocalSaveHistorySearch(
    boxKey: boxKey,
    saveCacheStorage: makeSaveCacheStorage(),
  );
}

FetchHistorySearch makeFetchHistorySearch() {
  return LocalFetchHistorySearch(
    boxKey: boxKey,
    fetchCacheStorage: makeFetchCacheStorage(),
  );
}
