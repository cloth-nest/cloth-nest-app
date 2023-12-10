import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class FetchRecommendationProduct {
  Future<List<ProductEntity>> call({required int idProduct});
}
