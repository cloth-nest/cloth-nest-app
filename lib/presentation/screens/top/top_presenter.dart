import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';
import 'package:flutter/material.dart';

abstract class TopPresenter implements ChangeNotifier {
  int get tabIndex;
  bool get isShowButton;
  TextEditingController get searchController;
  List<MyListEntity> get products;
  List<MyListEntity> get myListProducts;

  void changeTab(int newIndex);
  void onKeywordChanged(String keyword);
  void onClearText();
  void onSubmitted(String keyword);
  void fetchHistorySearch();
  void saveKeyword(String keyword);
  bool validateKeyWord(String keyword);
  void refreshState();
}
