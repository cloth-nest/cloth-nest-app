import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class FetchHistoryQrCode {
  Future<List<ProductEntity>> call();
}
