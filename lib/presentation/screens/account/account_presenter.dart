import 'package:flutter/material.dart';

abstract class AccountPresenter implements ChangeNotifier {
  void logout();
  void testAutoLogin();

  bool get isLoading;
  String? get navigateTo;
}
