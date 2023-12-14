import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

abstract class SearchDetailPresenter implements ChangeNotifier {
  Future<void> search(String keyword);
  Future<void> onRefresh(String keyword);
  void addToWishList({required ProductEntity product});
  void removeFromWishList({required ProductEntity product});

  List<ProductEntity> get searchProducts;
  bool get isLoading;
}
