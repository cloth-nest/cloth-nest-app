import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';

abstract class FetchDetailProduct {
  Future<DetailProductEntity> call({required int idProduct});
}
