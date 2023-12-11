import 'package:ecommerce/app/factories/cache/delete_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/wishlist/local_delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';

DeleteWishlist makeDeleteWishlist() {
  final deleteCacheStorage = makeDeleteCacheStorage();
  const boxKey = 'BOX_KEY_WISHLIST';

  return LocalDeleteWishlist(
    boxKey: boxKey,
    deleteCacheStorage: deleteCacheStorage,
  );
}
