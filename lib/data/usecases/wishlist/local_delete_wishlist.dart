import 'package:ecommerce/data/cache/delete_cache_storage.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';

class LocalDeleteWishlist implements DeleteWishlist {
  final String boxKey;
  final DeleteCacheStorage deleteCacheStorage;

  LocalDeleteWishlist({
    required this.boxKey,
    required this.deleteCacheStorage,
  });

  @override
  Future<void> deleteLocal({required int idProduct}) async {
    try {
      await deleteCacheStorage.deleteByKey(
        boxKey: boxKey,
        key: idProduct.toString(),
      );
    } catch (e) {
      throw Exception('Failed to delete local wishlist');
    }
  }
}
