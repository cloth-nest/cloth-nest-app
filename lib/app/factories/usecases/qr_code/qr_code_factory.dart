import 'package:ecommerce/app/factories/cache/delete_cache_storage_factory.dart';
import 'package:ecommerce/app/factories/cache/fetch_cache_storage.factory.dart';
import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/qr_code/local_delete_history_qr_code.dart';
import 'package:ecommerce/data/usecases/qr_code/local_fetch_history_qr_code.dart';
import 'package:ecommerce/data/usecases/qr_code/local_save_history_qr_code.dart';
import 'package:ecommerce/domain/usecases/qr_code/delete_history_qr_code.dart';
import 'package:ecommerce/domain/usecases/qr_code/fetch_history_qr_code.dart';
import 'package:ecommerce/domain/usecases/qr_code/save_history_qr_code.dart';

DeleteHistoryQrCode makeDeleteHistoryQrCode() {
  final deleteCacheStorage = makeDeleteCacheStorage();
  const boxKey = 'BOX_KEY_HISTORY_QR_CODE';

  return LocalDeleteHistoryQrCode(
    boxKey: boxKey,
    deleteCacheStorage: deleteCacheStorage,
  );
}

FetchHistoryQrCode makeFetchHistoryQrCode() {
  final fetchCacheStorage = makeFetchCacheStorage();
  const boxKey = 'BOX_KEY_HISTORY_QR_CODE';

  return LocalFetchHistoryQrCode(
    boxKey: boxKey,
    fetchCacheStorage: fetchCacheStorage,
  );
}

SaveHistoryQrCode makeSaveHistoryQrCode() {
  final saveCacheStorage = makeSaveCacheStorage();
  const boxKey = 'BOX_KEY_HISTORY_QR_CODE';

  return LocalSaveHistoryQrCode(
    boxKey: boxKey,
    saveCacheStorage: saveCacheStorage,
  );
}
