import 'package:flutter/material.dart';

abstract class SplashPresenter implements ChangeNotifier {
  void findNextRoute();

  String get navigateTo;
}
