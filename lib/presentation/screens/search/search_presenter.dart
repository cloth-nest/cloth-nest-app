import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:flutter/material.dart';

abstract class SearchPresenter implements ChangeNotifier {
  int get tabIndex;

  bool get isShowButton;

  TextEditingController get searchController;

  void changeTab(int newIndex);

  void onKeywordChanged(String keyword);

  void onClearText();

  void onSubmitted(String keyword);

  void fetchHistorySearch();

  void saveKeyword(String keyword);

  HistorySearchEntity get historySearch;

  bool validateKeyWord(String keyword);

  void refreshState();
}
