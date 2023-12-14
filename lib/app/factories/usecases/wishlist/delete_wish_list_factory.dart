import 'package:ecommerce/app/factories/cache/delete_cache_storage_factory.dart';
import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/wishlist/local_delete_wishlist.dart';
import 'package:ecommerce/data/usecases/wishlist/remote_delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';

DeleteWishlist makeDeleteWishlist() {
  final deleteCacheStorage = makeDeleteCacheStorage();
  const boxKey = 'BOX_KEY_WISHLIST';

  return LocalDeleteWishlist(
    boxKey: boxKey,
    deleteCacheStorage: deleteCacheStorage,
  );
}

DeleteRemoteWishlist makeRemoteDeleteWishList() {
  return RemoteDeleteWishlist(
    url: makeApiUrl('wishlist'),
    client: makeHttpAuthorizedAdapter(),
  );
}
