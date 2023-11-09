import 'package:ecommerce/app/factories/cache/delete_cache_storage_factory.dart';
import 'package:ecommerce/app/factories/cache/fetch_cache_storage.factory.dart';
import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/my_list/local_add_my_list.dart';
import 'package:ecommerce/data/usecases/my_list/local_delete_my_list.dart';
import 'package:ecommerce/data/usecases/my_list/local_fetch_my_list.dart';
import 'package:ecommerce/domain/usecases/my_list/add_my_list.dart';
import 'package:ecommerce/domain/usecases/my_list/delete_my_list.dart';
import 'package:ecommerce/domain/usecases/my_list/fetch_my_list.dart';

String boxKey = 'BOX_KEY_MY_LIST';

AddMyList makeLocalAddMyList() {
  return LocalAddMyList(
    boxKey: boxKey,
    saveCacheStorage: makeSaveCacheStorage(),
  );
}

FetchMyList makeLocalFetchMyList() {
  return LocalFetchMyList(
    boxKey: boxKey,
    fetchCacheStorage: makeFetchCacheStorage(),
  );
}

DeleteMyList makeLocalDeleteMyList() {
  return LocalDeleteMyList(
    boxKey: boxKey,
    deleteCacheStorage: makeDeleteCacheStorage(),
  );
}
