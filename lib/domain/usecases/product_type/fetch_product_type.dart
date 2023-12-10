import 'package:ecommerce/domain/entities/product_type/product_type_entity.dart';

abstract class FetchProductType {
  Future<List<ProductTypeEntity>> call();
}
