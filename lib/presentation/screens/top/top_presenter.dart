import 'package:flutter/material.dart';

abstract class TopPresenter implements ChangeNotifier {
  int get tabIndex;

  bool get isShowButton;

  TextEditingController get searchController;

  void changeTab(int newIndex);

  void onKeywordChanged(String keyword);

  void onClearText();

  void onSubmitted(String keyword);

  void fetchHistorySearch();

  void saveKeyword(String keyword);

  bool validateKeyWord(String keyword);

  void refreshState();
}
