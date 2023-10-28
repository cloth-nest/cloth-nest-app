import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:flutter/material.dart';

abstract class LoginPresenter implements ChangeNotifier {
  void login();
  void toggleAutoLogin();
  void setLoginId(String loginId);
  void setPassword(String password);
  void navigateToSignUpScreen();
  void navigateToForgetPasswordScreen();
  void toggleShowPassword();
  void resetState();

  bool get isShowPassword;
  bool get isLoading;
  LoginRedirect? get navigateTo;
  bool get isFormValid;
  String? get errorMessage;
  RememberChoice get rememberChoice;
  String get loginId;
}
