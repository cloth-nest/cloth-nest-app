import 'package:ecommerce/data/http/exceptions/http_exception.dart';
import 'package:ecommerce/domain/usecases/authentication/sign_up/fetch_sign_up.dart';
import 'package:ecommerce/domain/usecases/authentication/sign_up/sign_up_params.dart';
import 'package:ecommerce/presentation/presenters/sign_up/sign_up_state.dart';
import 'package:ecommerce/presentation/protocols/validation.dart';
import 'package:ecommerce/presentation/screens/sign_up/sign_up_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSignUpPresenter with ChangeNotifier implements SignUpPresenter {
  SignUpState _state;
  final Validation _validation;
  final FetchSignUp _fetchSignUp;

  ProviderSignUpPresenter({
    required SignUpState state,
    required Validation validation,
    required FetchSignUp fetchSignUp,
  })  : _state = state,
        _validation = validation,
        _fetchSignUp = fetchSignUp;

  void _validateEmail() {
    final exceptions = _validation.validate(
      field: 'loginId',
      input: {'loginId': _state.loginId},
    );

    if (exceptions.isNotEmpty) {
      _state = _state.copyWith(
        errorMessage:
            'Can not sign up. Please enter your email address and password correctly.',
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
            'Can not sign up. Please enter your email address and password correctly.',
      );
    }
  }

  @override
  void signUp() async {
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
      final SignUpParams signUpParams = SignUpParams(
        email: _state.loginId ?? '',
        password: _state.password ?? '',
        firstName: _state.firstName ?? '',
        lastName: _state.lastName ?? '',
      );

      await _fetchSignUp.call(params: signUpParams);

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: SignUpRedirect.verifyEmail,
      );
      notifyListeners();
    } on HttpException catch (e) {
      _state = _state.copyWith(isLoading: false, errorMessage: e.message);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false, errorMessage: e.toString());
      notifyListeners();
    }
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  SignUpRedirect? get navigateTo => _state.navigateTo;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  bool get isFormValid => _state.isFormValid;

  void _validateForm() {
    _state = _state.copyWith(
      isFormValid: _state.loginId != null &&
          _state.loginId!.isNotEmpty &&
          _state.password != null &&
          _state.password!.isNotEmpty &&
          _state.firstName != null &&
          _state.firstName!.isNotEmpty &&
          _state.lastName != null &&
          _state.lastName!.isNotEmpty,
    );
    notifyListeners();
  }

  @override
  void setLoginId(String loginId) {
    _state = _state.copyWith(loginId: loginId);
    _validateForm();
  }

  @override
  void setPassword(String password) {
    _state = _state.copyWith(password: password);
    _validateForm();
  }

  @override
  void setFirstName(String firstName) {
    _state = _state.copyWith(firstName: firstName);
    _validateForm();
  }

  @override
  void setLastName(String lastName) {
    _state = _state.copyWith(lastName: lastName);
    _validateForm();
  }

  @override
  void toggleShowPassword() {
    _state = _state.copyWith(isShowPassword: !_state.isShowPassword);
    notifyListeners();
  }

  @override
  bool get isShowPassword => _state.isShowPassword;

  @override
  void navigateToLoginScreen() {
    _state = _state.copyWith(navigateTo: SignUpRedirect.login);
    notifyListeners();
  }

  @override
  void navigateToVerifyEmailScreen() {
    _state = _state.copyWith(navigateTo: SignUpRedirect.verifyEmail);
    notifyListeners();
  }

  @override
  void resetState() {
    _state = SignUpState.initial();
  }

  @override
  String get loginId => _state.loginId ?? '';
}
