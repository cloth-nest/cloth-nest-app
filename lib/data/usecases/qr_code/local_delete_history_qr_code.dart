import 'package:ecommerce/data/cache/delete_cache_storage.dart';
import 'package:ecommerce/domain/usecases/qr_code/delete_history_qr_code.dart';

class LocalDeleteHistoryQrCode implements DeleteHistoryQrCode {
  final String boxKey;
  final DeleteCacheStorage deleteCacheStorage;

  LocalDeleteHistoryQrCode({
    required this.boxKey,
    required this.deleteCacheStorage,
  });

  @override
  Future<void> call() async {
    try {
      await deleteCacheStorage.deleteAll(
        boxKey: boxKey,
      );
    } catch (e) {
      throw Exception('Failed to delete all history qr code');
    }
  }
}
