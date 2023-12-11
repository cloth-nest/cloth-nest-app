import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class SaveWishlist {
  Future<void> saveLocal({required ProductEntity product});
}
