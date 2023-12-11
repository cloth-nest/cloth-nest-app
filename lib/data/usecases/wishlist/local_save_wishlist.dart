import 'package:ecommerce/data/cache/save_cache_storage.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';

class LocalSaveWishlist implements SaveWishlist {
  final String boxKey;
  final SaveCacheStorage saveCacheStorage;

  LocalSaveWishlist({
    required this.boxKey,
    required this.saveCacheStorage,
  });

  @override
  Future<void> saveLocal({required ProductEntity product}) async {
    final ProductModel model = product.toModel();

    try {
      await saveCacheStorage.put(
        boxKey: boxKey,
        key: product.id.toString(),
        value: model,
      );
    } catch (e) {
      throw Exception('Failed to save local wishlist');
    }
  }
}
