import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_remove_from_cart.dart';

class RemoteFetchRemoveFromCart implements FetchRemoveFromCart {
  final HttpClient client;
  final String url;

  RemoteFetchRemoveFromCart({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required int variantId, required int quantity}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.delete,
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
