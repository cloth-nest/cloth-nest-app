import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:flutter/material.dart';

class ProviderLoginPresenter with ChangeNotifier implements LoginPresenter {
  // The current state of the login screen
  LoginState state;

  @override
  void login() async {
    try {
      state = state.copyWith(isLoading: true);
      await Future.delayed(const Duration(seconds: 5));
    } catch (_) {
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  ProviderLoginPresenter({
    required this.state,
  });
}
