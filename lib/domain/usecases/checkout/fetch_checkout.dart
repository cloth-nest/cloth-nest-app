import 'package:ecommerce/domain/entities/order/order_entity.dart';

abstract class FetchCheckOut {
  Future<OrderEntity> checkOutFromCart({
    required int addressId,
    required String phone,
    required String paymentMethod,
    required int ghnServerTypeId,
  });

  Future<OrderEntity> checkOutNow({
    required int addressId,
    required String phone,
    required String paymentMethod,
    required int ghnServerTypeId,
    required int variantId,
    required int quantity,
  });
}
