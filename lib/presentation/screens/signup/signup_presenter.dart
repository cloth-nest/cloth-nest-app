import 'package:ecommerce/presentation/presenters/signup/signup_state.dart';
import 'package:flutter/material.dart';

abstract class SignupPresenter implements ChangeNotifier {
  void signup({required String email, required String password});

  bool get isLoading;

  SignupRedirect? get navigateTo;
}
