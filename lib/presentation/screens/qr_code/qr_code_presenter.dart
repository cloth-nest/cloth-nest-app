import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

abstract class QrCodePresenter implements ChangeNotifier {
  bool get isLoading;
  List<ProductEntity> get products;

  void initData();
  void saveProduct({required int idProduct});
  void addToWishList({required ProductEntity product});
  void removeFromWishList({required ProductEntity product});
  void deleteAll();
}
