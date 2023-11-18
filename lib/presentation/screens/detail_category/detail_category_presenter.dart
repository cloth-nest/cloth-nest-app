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

  void changeTab(int newIndex);
  Future pullToRefresh();
  void setSelectedSizes(List<Map<String, dynamic>> value);
  void setSelectedColors(List<Map<String, dynamic>> value);
  void setSelectedPrices(List<Map<String, dynamic>> value);
  void setSort(String value);
}
