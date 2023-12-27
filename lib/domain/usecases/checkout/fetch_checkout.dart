import 'package:ecommerce/domain/entities/order/order_entity.dart';

abstract class FetchCheckOut {
  Future<OrderEntity> call({
    required int addressId,
    required String phone,
    required String paymentMethod,
    required int ghnServerTypeId,
  });
}
