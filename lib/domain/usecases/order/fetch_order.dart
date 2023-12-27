import 'package:ecommerce/domain/entities/order/order_entity.dart';

abstract class FetchOrder {
  Future<List<OrderEntity>> call({
    required int page,
    required int limit,
  });
}
