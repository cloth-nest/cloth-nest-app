import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:flutter/foundation.dart';

abstract class CartPresenter implements ChangeNotifier {
  Future<void> refreshData();
  void initData();
  void addToCart({required int variantId});
  void removeFromCart({required int variantId});

  bool get isLoading;
  List<CartEntity> get carts;
}
