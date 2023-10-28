import 'package:ecommerce/presentation/presenters/verify_email/verify_email_state.dart';
import 'package:flutter/material.dart';

abstract class VerifyEmailPresenter with ChangeNotifier {
  void verifyEmail(String email);
  void resendCode(String emaill);
  void setOtpCode(String value);
  void resetState();

  String get otpCode;
  bool get isLoading;
  String? get errorMessage;
  bool get isFormValid;
  VerifyEmailRedirect? get navigateTo;
  TextEditingController get controller;
}
