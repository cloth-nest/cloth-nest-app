import 'package:ecommerce/domain/entities/product/product_entity.dart';

abstract class SaveHistoryQrCode {
  Future<void> call({required ProductEntity product});
}
