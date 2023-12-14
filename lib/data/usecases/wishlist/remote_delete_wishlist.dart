import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';

class RemoteDeleteWishlist implements DeleteRemoteWishlist {
  final String url;
  final HttpClient client;

  RemoteDeleteWishlist({
    required this.client,
    required this.url,
  });

  @override
  Future<void> deleteRemote({required List<int> variantIds}) async {
    try {
      final response = await client
          .makeRequest(uri: Uri.parse(url), method: HttpMethod.delete, body: {
        'variantIds': variantIds,
      });
      ResponseHandler.handle(response);
    } catch (e) {
      rethrow;
    }
  }
}
