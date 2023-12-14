import 'package:flutter/material.dart';

abstract class SearchPresenter implements ChangeNotifier {
  int get tabIndex;

  void changeTab(int newIndex);
}
