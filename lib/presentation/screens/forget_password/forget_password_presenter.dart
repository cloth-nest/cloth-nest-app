import 'package:flutter/material.dart';

abstract class ForgetPasswordPresenter implements ChangeNotifier {
  void send();
  void setEmail(String? value);

  bool get isLoading;
  String? get errorMessage;
  String? get navigateTo;
  bool get isFormValid;
  String get email;
}
