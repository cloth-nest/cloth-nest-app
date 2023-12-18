import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_add_to_cart.dart';

class RemoteFetchAddToCart implements FetchAddToCart {
  final HttpClient client;
  final String url;

  RemoteFetchAddToCart({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required int variantId, required int quantity}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: {
          'variantId': variantId,
          'quantity': quantity,
        },
      );
      ResponseHandler.handle(response);
    } catch (e) {
      rethrow;
    }
  }
}
