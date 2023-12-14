import 'package:ecommerce/app/factories/cache/delete_cache_storage_factory.dart';
import 'package:ecommerce/app/factories/cache/fetch_cache_storage.factory.dart';
import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/app/factories/cache/watch_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/token/local_delete_token.dart';
import 'package:ecommerce/data/usecases/token/local_fetch_token.dart';
import 'package:ecommerce/data/usecases/token/local_save_token.dart';
import 'package:ecommerce/data/usecases/token/local_watch_token.dart';
import 'package:ecommerce/domain/usecases/token/delete_token.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';
import 'package:ecommerce/domain/usecases/token/watch_token.dart';

SaveToken makeSaveLocalToken() {
  final saveSecureCacheStorage = makeSaveSecureCacheStorage();
  const boxKey = 'BOX_KEY_TOKEN';
  const encryptionKey = 'KEY_ENCRYPTED_TOKEN';

  return LocalSaveToken(
    boxKey: boxKey,
    encryptionKey: encryptionKey,
    saveSecureCacheStorage: saveSecureCacheStorage,
  );
}

FetchToken makeFetchLocalToken() {
  final fetchSecureCacheStorage = makeFetchSecureCacheStorage();
  const boxKey = 'BOX_KEY_TOKEN';
  const encryptionKey = 'KEY_ENCRYPTED_TOKEN';

  return LocalFetchToken(
    boxKey: boxKey,
    encryptionKey: encryptionKey,
    fetchSecureCacheStorage: fetchSecureCacheStorage,
  );
}

DeleteToken makeDeleteLocalToken() {
  final deleteSecureCacheStorage = makeDeleteSecureCacheStorage();
  const boxKey = 'BOX_KEY_TOKEN';
  const encryptionKey = 'KEY_ENCRYPTED_TOKEN';

  return LocalDeleteToken(
    boxKey: boxKey,
    encryptionKey: encryptionKey,
    deleteSecureCacheStorage: deleteSecureCacheStorage,
  );
}

ListenerUserToken makeListenLocalUserToken() {
  final listenerCacheStorage = makeWatchSecureCacheStorage();
  const boxKey = 'BOX_KEY_TOKEN';
  const encryptionKey = 'KEY_ENCRYPTED_TOKEN';

  return LocalListenerUserToken(
    boxKey: boxKey,
    encryptionKey: encryptionKey,
    listenerCacheStorage: listenerCacheStorage,
  );
}
