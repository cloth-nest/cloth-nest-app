import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class SaveLocalWishlist {
  Future<void> saveLocal({required ProductEntity product});
}

abstract class SaveRemoteWishlist {
  Future<void> saveRemote({required List<int> variantIds});
}
