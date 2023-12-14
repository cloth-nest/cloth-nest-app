import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:flutter/material.dart';

abstract class SearchSharedPresenter implements ChangeNotifier {
  bool get isShowButton;

  TextEditingController get searchController;

  void onKeywordChanged(String keyword);

  void onClearText();

  void onSubmitted(String keyword);

  void fetchHistorySearch();

  void saveKeyword(String keyword);

  HistorySearchEntity get historySearch;

  bool validateKeyWord(String keyword);

  void refreshState();
}
