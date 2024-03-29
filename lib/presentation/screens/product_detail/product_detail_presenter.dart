import 'package:ecommerce/domain/entities/detail_product/attribute_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/variant_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/warehouse_stock_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/entities/review/review_entity.dart';
import 'package:flutter/material.dart';

abstract class ProductDetailPresenter implements ChangeNotifier {
  int get activePage;
  PageController get pageController;
  int get tabIndex;
  bool get isLoading;
  List<ImageEntity> get images;
  List<AttributeEntity> get attributes;
  String get name;
  double get price;
  List<ProductEntity> get recommendationProducts;
  List<String> get sizes;
  List<AttributeVariantProductEntity> get colors;
  String get selectedColor;
  String get selectedSize;
  bool get isFavorite;
  DetailProductEntity? get entity;
  bool? get successAddToCart;
  String get sizeChartImage;
  List<ReviewEntity> get reviews;
  VariantEntity get selectedVariantEntity;
  List<WarehouseStockEntity> get warehouses;

  int? getOrderImage(int id);
  void setActivePage(int page);
  void setTabIndex(int index);
  void initData({required int idProduct});
  void setSelectedColor({required String colorName});
  void setSelectedSize({required int index, required String size});
  void addToWishList({required ProductEntity product});
  void removeFromWishList({required ProductEntity product});
  void addToCart();
}
