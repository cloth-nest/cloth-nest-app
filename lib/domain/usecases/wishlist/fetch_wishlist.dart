import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class FetchWishlist {
  Future<List<ProductEntity>> fetchLocal();
}
