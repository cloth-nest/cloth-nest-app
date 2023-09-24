import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/login/fetch_login.dart';
import 'package:ecommerce/domain/usecases/authentication/login/login_params.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';
import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:flutter/material.dart';

class ProviderLoginPresenter with ChangeNotifier implements LoginPresenter {
  // The current state of the login screen
  LoginState _state;

  final FetchLogin _fetchLogin;
  final SaveToken _saveToken;

  @override
  void login({required String email, required String password}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      final loginParams = LoginParams(
        email: email,
        password: password,
      );

      TokenEntity tokenEntity =
          await _fetchLogin.call(loginParams: loginParams);
      await _saveToken.call(tokenEntity: tokenEntity);

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: LoginRedirect.homeAuth,
      );
      notifyListeners();
    } catch (_) {}
  }

  ProviderLoginPresenter({
    required LoginState state,
    required FetchLogin fetchLogin,
    required SaveToken saveToken,
  })  : _state = state,
        _fetchLogin = fetchLogin,
        _saveToken = saveToken;

  @override
  bool get isLoading => _state.isLoading;

  @override
  LoginRedirect? get navigateTo => _state.navigateTo;
}
