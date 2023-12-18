import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/cart/cart_model.dart';
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_cart.dart';

class RemoteFetchCart implements FetchCart {
  final HttpClient client;
  final String url;

  RemoteFetchCart({
    required this.client,
    required this.url,
  });

  @override
  Future<List<CartEntity>> call() async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      final List<CartEntity> carts = List.from(json['data'])
          .map((e) => CartModel.fromMap(e).toEntity())
          .toList();

      return carts;
    } catch (e) {
      rethrow;
    }
  }
}
