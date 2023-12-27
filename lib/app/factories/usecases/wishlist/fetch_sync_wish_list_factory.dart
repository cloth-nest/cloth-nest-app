import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/wishlist/remote_fetch_sync_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_sync_wishlist.dart';

FetchSyncWishlist makeRemoteFetchSyncWishlist() {
  return RemoteFetchSyncWishlist(
    client: makeHttpAuthorizedAdapter(),
    url: makeApiUrl('wishlist'),
  );
}
