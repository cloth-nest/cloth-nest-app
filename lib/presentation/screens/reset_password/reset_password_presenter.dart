import 'package:flutter/foundation.dart';

abstract class ResetPasswordPresenter implements ChangeNotifier {
  void resetPassword({required String email});
  void setPassword(String? value);
  void setConfirmPassword(String? value);
  void toggleShowConfirmPassword();
  void toggleShowPassword();

  bool get isLoading;
  bool get isValidForm;
  bool get isShowPassword;
  bool get isShowConfirmPassword;
  String? get navigateTo;
  String? get errorMessage;
}
