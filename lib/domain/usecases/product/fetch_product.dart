import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product_params.dart';

abstract class FetchProduct {
  Future<List<ProductEntity>> call({required FetchProductParams params});
}
