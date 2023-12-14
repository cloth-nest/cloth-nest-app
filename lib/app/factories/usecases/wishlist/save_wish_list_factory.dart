import 'package:ecommerce/app/factories/cache/save_cache_storage_factory.dart';
import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/wishlist/local_save_wishlist.dart';
import 'package:ecommerce/data/usecases/wishlist/remote_save_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';

SaveLocalWishlist makeSaveWishList() {
  final saveCacheStorage = makeSaveCacheStorage();
  const boxKey = 'BOX_KEY_WISHLIST';

  return LocalSaveWishlist(
    boxKey: boxKey,
    saveCacheStorage: saveCacheStorage,
  );
}

SaveRemoteWishlist makeRemoteSaveWishList() {
  return RemoteSaveWishlist(
    url: makeApiUrl('wishlist'),
    client: makeHttpAuthorizedAdapter(),
  );
}
