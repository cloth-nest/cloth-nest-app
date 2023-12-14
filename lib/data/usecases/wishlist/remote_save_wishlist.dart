import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';

import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';

class RemoteSaveWishlist implements SaveRemoteWishlist {
  final String url;
  final HttpClient client;

  RemoteSaveWishlist({
    required this.client,
    required this.url,
  });

  @override
  Future<void> saveRemote({required List<int> variantIds}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: {
          'variantIds': variantIds,
        },
      );
      ResponseHandler.handle(response);
    } catch (e) {
      rethrow;
    }
  }
}
