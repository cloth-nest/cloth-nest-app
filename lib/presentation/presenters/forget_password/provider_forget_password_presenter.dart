import 'package:ecommerce/data/http/exceptions/http_exception.dart';
import 'package:ecommerce/domain/usecases/authentication/forget_password/fetch_forget_password.dart';
import 'package:ecommerce/domain/usecases/authentication/forget_password/forget_password_params.dart';
import 'package:ecommerce/presentation/presenters/forget_password/forget_password_state.dart';
import 'package:ecommerce/presentation/protocols/validation.dart';
import 'package:ecommerce/presentation/screens/forget_password/forget_password_presenter.dart';
import 'package:flutter/material.dart';

class ProviderForgetPasswordPresenter
    with ChangeNotifier
    implements ForgetPasswordPresenter {
  ForgetPasswordState _state;
  final Validation _validation;
  final FetchForgetPassword _fetchForgetPassword;

  ProviderForgetPasswordPresenter(
      {required ForgetPasswordState state,
      required Validation validation,
      required FetchForgetPassword fetchForgetPassword})
      : _state = state,
        _validation = validation,
        _fetchForgetPassword = fetchForgetPassword;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  bool get isFormValid => _state.isFormValid;

  @override
  bool get isLoading => _state.isLoading;

  @override
  String? get navigateTo => _state.navigateTo;

  void _validateEmail() {
    final exceptions = _validation.validate(
      field: 'loginId',
      input: {'loginId': _state.email},
    );

    if (exceptions.isNotEmpty) {
      _state = _state.copyWith(
        errorMessage: 'Please enter your email address correctly.',
      );
    }
  }

  void _validateForm() {
    _state = _state.copyWith(isFormValid: _state.email.isNotEmpty);
    notifyListeners();
  }

  @override
  void setEmail(String? value) {
    // Update the state with the new login ID
    _state = _state.copyWith(email: value?.trim());
    _validateForm();
  }

  @override
  void send() async {
    if (_state.isFormValid == false || _state.isLoading) {
      return;
    }

    _state = _state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    _validateEmail();

    if (_state.errorMessage != null) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: _state.errorMessage,
      );
      notifyListeners();
      return;
    }

    try {
      await _fetchForgetPassword.call(
          params: ForgetPasswordParams(
        email: _state.email,
      ));
      _state = _state.copyWith(
        isLoading: false,
        navigateTo: '/verify',
      );
      notifyListeners();
    } on HttpException catch (_) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Email is not registered',
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Email is not registered',
      );
      notifyListeners();
    }
  }

  @override
  String get email => _state.email;
}
