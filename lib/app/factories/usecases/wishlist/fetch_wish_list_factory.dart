import 'package:ecommerce/app/factories/cache/fetch_cache_storage.factory.dart';
import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/wishlist/local_fetch_wishlist.dart';
import 'package:ecommerce/data/usecases/wishlist/remote_fetch_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';

FetchWishlist makeFetchWishlist() {
  final fetchCacheStorage = makeFetchCacheStorage();
  const boxKey = 'BOX_KEY_WISHLIST';

  return LocalFetchWishlist(
    boxKey: boxKey,
    fetchCacheStorage: fetchCacheStorage,
  );
}

FetchRemoteWishlist makeRemoteFetchWishlist() {
  return RemoteFetchWishlist(
    client: makeHttpAuthorizedAdapter(),
    url: makeApiUrl('wishlist'),
  );
}
