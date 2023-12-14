import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/wishlist/wishlist_model.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';

class RemoteFetchWishlist implements FetchRemoteWishlist {
  final String url;
  final HttpClient client;

  RemoteFetchWishlist({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ProductEntity>> fetchRemote() async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      final List<WishlistModel> wishlists =
          List.from(json['data']).map((e) => WishlistModel.fromMap(e)).toList();
      final List<ProductEntity> products = [];

      for (var wishlist in wishlists) {
        products.add(wishlist.toProductEntity());
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
