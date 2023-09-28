import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:flutter/material.dart';

abstract class LoginPresenter implements ChangeNotifier {
  void login(
      {required String email,
      required String password,
      required bool rememberLogin});

  bool get isLoading;

  LoginRedirect? get navigateTo;
}
