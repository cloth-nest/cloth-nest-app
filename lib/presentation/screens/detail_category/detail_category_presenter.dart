import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

abstract class DetailCategoryPresenter implements ChangeNotifier {
  bool get isLoading;
  int get tabIndex;
  List<String> get sizes;
  List<String> get colors;
  List<String> get prices;
  List<Map<String, dynamic>> get selectedSizes;
  List<Map<String, dynamic>> get selectedColors;
  List<Map<String, dynamic>> get selectedPrices;
  bool get hasFilter;
  String get sort;
  List<ProductEntity> get products;
  ScrollController get controller;
  bool get canGetMore;
  bool get isGetMore;

  void changeTab(int newIndex,
      {required int id, required int page, required int limit});
  Future pullToRefresh();
  void setSelectedSizes(List<Map<String, dynamic>> value);
  void setSelectedColors(List<Map<String, dynamic>> value);
  void setSelectedPrices(List<Map<String, dynamic>> value);
  void setSort(String value);
  void initData({required int id, required int page, required int limit});
  void scrollListener();
}
