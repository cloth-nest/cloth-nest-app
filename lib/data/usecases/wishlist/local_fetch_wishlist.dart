import 'package:ecommerce/data/cache/fetch_cache_storage.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';

class LocalFetchWishlist implements FetchWishlist {
  final String boxKey;
  final FetchCacheStorage fetchCacheStorage;

  LocalFetchWishlist({
    required this.boxKey,
    required this.fetchCacheStorage,
  });

  @override
  Future<List<ProductEntity>> fetchLocal() async {
    try {
      final List<dynamic> products =
          await fetchCacheStorage.fetchAll(boxKey: boxKey);
      return products.map((e) => (e as ProductModel).toEntity()).toList();
    } catch (e) {
      throw Exception('Fetch all my list failed');
    }
  }
}
