import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class FetchSearch {
  Future<List<ProductEntity>> call({
    required String search,
    required int page,
    required int limit,
  });
}
