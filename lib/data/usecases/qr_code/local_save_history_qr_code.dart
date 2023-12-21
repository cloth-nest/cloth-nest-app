import 'package:ecommerce/data/cache/save_cache_storage.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/qr_code/save_history_qr_code.dart';

class LocalSaveHistoryQrCode implements SaveHistoryQrCode {
  final String boxKey;
  final SaveCacheStorage saveCacheStorage;

  LocalSaveHistoryQrCode({
    required this.boxKey,
    required this.saveCacheStorage,
  });

  @override
  Future<void> call({required ProductEntity product}) async {
    final ProductModel model = product.toModel();

    try {
      await saveCacheStorage.put(
        boxKey: boxKey,
        key: product.defaultVariantId.toString(),
        value: model,
      );
    } catch (e) {
      throw Exception('Failed to save local history qr code');
    }
  }
}
