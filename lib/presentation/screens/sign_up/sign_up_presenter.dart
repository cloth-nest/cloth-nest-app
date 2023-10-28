import 'package:ecommerce/presentation/presenters/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';

abstract class SignUpPresenter implements ChangeNotifier {
  void signUp();
  void setLoginId(String loginId);
  void setPassword(String password);
  void setFirstName(String firstName);
  void setLastName(String lastName);
  void navigateToLoginScreen();
  void navigateToVerifyEmailScreen();
  void toggleShowPassword();
  void resetState();

  bool get isShowPassword;
  bool get isLoading;
  String get loginId;
  SignUpRedirect? get navigateTo;
  bool get isFormValid;
  String? get errorMessage;
}
