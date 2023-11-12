import 'package:ecommerce/data/http/exceptions/http_exception.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/login/fetch_login.dart';
import 'package:ecommerce/domain/usecases/authentication/login/login_params.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';
import 'package:ecommerce/presentation/presenters/authentication/provider_authentication_presenter.dart';
import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/protocols/validation.dart';
import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:flutter/material.dart';

class ProviderLoginPresenter with ChangeNotifier implements LoginPresenter {
  // The current state of the login screen
  LoginState _state;

  final FetchLogin _fetchLogin;
  final SaveToken _saveToken;
  final Validation _validation;
  final AuthenticationPresenter _authenticationPresenter;

  void _validateEmail() {
    final exceptions = _validation.validate(
      field: 'loginId',
      input: {'loginId': _state.loginId},
    );

    if (exceptions.isNotEmpty) {
      _state = _state.copyWith(
        errorMessage:
            'Can not login. Please enter your email address and password correctly.',
      );
    }
  }

  void _validatePassword() {
    final exceptions = _validation.validate(
      field: 'password',
      input: {'password': _state.password},
    );

    if (exceptions.isNotEmpty) {
      _state = _state.copyWith(
        errorMessage:
            'Can not login. Please enter your email address and password correctly.',
      );
    }
  }

  void _validateForm() {
    _state = _state.copyWith(
      isFormValid: _state.loginId != null &&
          _state.loginId!.isNotEmpty &&
          _state.password != null &&
          _state.password!.isNotEmpty,
    );
    notifyListeners();
  }

  @override
  void setLoginId(String loginId) {
    // Update the state with the new login ID
    _state = _state.copyWith(loginId: loginId.trim());
    _validateForm();
  }

  @override
  void setPassword(String password) {
    // Update the state with the new password
    _state = _state.copyWith(password: password.trim());
    _validateForm();
  }

  @override
  void login() async {
    if (!_state.isFormValid || _state.isLoading) {
      return;
    }

    _state = _state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    _validateEmail();
    _validatePassword();

    if (_state.errorMessage != null) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: _state.errorMessage,
      );
      notifyListeners();
      return;
    }

    try {
      final loginParams = LoginParams(
        email: _state.loginId ?? '',
        password: _state.password ?? '',
      );

      TokenEntity tokenEntity =
          await _fetchLogin.call(loginParams: loginParams);

      tokenEntity = tokenEntity.copyWith(
        isRemember:
            _state.rememberChoice == RememberChoice.remember ? true : false,
      );

      await _saveToken.call(tokenEntity: tokenEntity);

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: LoginRedirect.homeAuth,
      );

      notifyListeners();
    } on HttpException catch (e) {
      LoginRedirect? navigateTo;
      String? error;

      if (e.code == 'C0003') {
        navigateTo = LoginRedirect.verifyEmail;
      } else {
        error =
            'Can not login. Please enter your email address and password correctly.';
      }
      _state = _state.copyWith(
        isLoading: false,
        navigateTo: navigateTo,
        errorMessage: error,
      );
      notifyListeners();
    } catch (_) {
      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  ProviderLoginPresenter({
    required LoginState state,
    required FetchLogin fetchLogin,
    required SaveToken saveToken,
    required Validation validation,
    required AuthenticationPresenter authenticationPresenter,
  })  : _state = state,
        _fetchLogin = fetchLogin,
        _saveToken = saveToken,
        _validation = validation,
        _authenticationPresenter = authenticationPresenter;

  @override
  bool get isLoading => _state.isLoading;

  @override
  LoginRedirect? get navigateTo => _state.navigateTo;

  @override
  bool get isFormValid => _state.isFormValid;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  RememberChoice get rememberChoice => _state.rememberChoice;

  @override
  void toggleAutoLogin() {
    if (_state.rememberChoice == RememberChoice.forget) {
      _state = _state.copyWith(rememberChoice: RememberChoice.remember);
    } else {
      _state = _state.copyWith(rememberChoice: RememberChoice.forget);
    }
    notifyListeners();
  }

  @override
  void navigateToForgetPasswordScreen() {
    _state = _state.copyWith(navigateTo: LoginRedirect.forgetPassword);
    notifyListeners();
  }

  @override
  void navigateToSignUpScreen() {
    _state = _state.copyWith(navigateTo: LoginRedirect.signUp);
    notifyListeners();
  }

  @override
  void toggleShowPassword() {
    _state = _state.copyWith(isShowPassword: !_state.isShowPassword);
    notifyListeners();
  }

  @override
  bool get isShowPassword => _state.isShowPassword;

  @override
  void resetState() {
    _state = LoginState.initial();
  }

  @override
  String get loginId => _state.loginId ?? '';

  @override
  void loginAsGuest() {
    _authenticationPresenter.changeAuthenticatedState(AuthenticatedState.guest);
    _state = _state.copyWith(
      navigateTo: LoginRedirect.home,
    );
    notifyListeners();
  }
}
