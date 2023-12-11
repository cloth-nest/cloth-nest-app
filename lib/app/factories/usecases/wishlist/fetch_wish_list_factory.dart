import 'package:ecommerce/app/factories/cache/fetch_cache_storage.factory.dart';
import 'package:ecommerce/data/usecases/wishlist/local_fetch_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';

FetchWishlist makeFetchWishlist() {
  final fetchCacheStorage = makeFetchCacheStorage();
  const boxKey = 'BOX_KEY_WISHLIST';

  return LocalFetchWishlist(
    boxKey: boxKey,
    fetchCacheStorage: fetchCacheStorage,
  );
}
