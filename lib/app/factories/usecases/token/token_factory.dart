import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/token/local_save_token.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';

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
