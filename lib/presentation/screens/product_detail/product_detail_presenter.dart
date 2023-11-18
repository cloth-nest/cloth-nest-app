import 'package:flutter/material.dart';

abstract class ProductDetailPresenter implements ChangeNotifier {
  int get activePage;
  PageController get pageController;
  int get tabIndex;

  void setActivePage(int page);
  void setTabIndex(int index);
}
