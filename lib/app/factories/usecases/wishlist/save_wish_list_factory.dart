import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/data/usecases/wishlist/local_save_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';

SaveWishlist makeSaveWishList() {
  final saveCacheStorage = makeSaveCacheStorage();
  const boxKey = 'BOX_KEY_WISHLIST';

  return LocalSaveWishlist(
    boxKey: boxKey,
    saveCacheStorage: saveCacheStorage,
  );
}
