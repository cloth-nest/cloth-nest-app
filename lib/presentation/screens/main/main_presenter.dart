import 'package:flutter/material.dart';

abstract class MainPresenter implements ChangeNotifier {
  int get beforeIndex;
  int get currentIndex;

  void changeIndex(int newIndex);
}
