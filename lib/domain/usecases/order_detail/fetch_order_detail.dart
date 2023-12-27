import 'package:ecommerce/domain/entities/order/order_entity.dart';

abstract class FetchOrderDetail {
  Future<OrderEntity> call({required int idOrder});
}
