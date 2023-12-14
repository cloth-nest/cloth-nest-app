import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:flutter/foundation.dart';

abstract class MyListPresenter implements ChangeNotifier {
  Future<void> refreshData();
  void getData();
  Future<void> removeFromWishlist({required ProductEntity entity});

  bool get isLoading;
  List<ProductEntity> get myListProducts;
}
