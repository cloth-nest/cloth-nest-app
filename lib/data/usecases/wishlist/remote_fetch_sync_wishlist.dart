import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_sync_wishlist.dart';

class RemoteFetchSyncWishlist implements FetchSyncWishlist {
  final String url;
  final HttpClient client;

  RemoteFetchSyncWishlist({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required List<int> variantIds}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.patch,
        body: {
          "variantIds": variantIds,
        },
      );
      ResponseHandler.handle(response);
    } catch (e) {
      rethrow;
    }
  }
}
