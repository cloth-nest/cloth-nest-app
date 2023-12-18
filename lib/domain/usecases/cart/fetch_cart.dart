import 'package:ecommerce/domain/entities/cart/cart_entity.dart';

abstract class FetchCart {
  Future<List<CartEntity>> call();
}
