import 'package:ecommerce/presentation/presenters/signup/signup_state.dart';
import 'package:ecommerce/presentation/screens/signup/signup_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSignupPresenter with ChangeNotifier implements SignupPresenter {
  SignupState _state;

  @override
  void signup({required String email, required String password}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      // TODO: Signup API Call
      // final loginParams = SignupParams(
      //   email: email,
      //   password: password,
      // );

      // TokenEntity tokenEntity =
      //     await _fetchSignup.call(loginParams: loginParams);

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: SignupRedirect.homeAuth,
      );
      notifyListeners();
    } catch (_) {}
  }

  ProviderSignupPresenter({
    required SignupState state,
  }) : _state = state;

  @override
  bool get isLoading => _state.isLoading;

  @override
  SignupRedirect? get navigateTo => _state.navigateTo;
}
