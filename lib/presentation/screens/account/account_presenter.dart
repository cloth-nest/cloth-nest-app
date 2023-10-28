import 'package:flutter/material.dart';

abstract class AccountPresenter implements ChangeNotifier {
  void logout();

  bool get isLoading;
  String? get navigateTo;
}
