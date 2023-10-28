import 'package:ecommerce/data/http/exceptions/http_exception.dart';
import 'package:ecommerce/domain/usecases/authentication/reset_password/fetch_reset_password.dart';
import 'package:ecommerce/domain/usecases/authentication/reset_password/reset_password_params.dart';
import 'package:ecommerce/presentation/presenters/reset_password/reset_password_state.dart';
import 'package:ecommerce/presentation/protocols/validation.dart';
import 'package:ecommerce/presentation/screens/reset_password/reset_password_presenter.dart';
import 'package:flutter/material.dart';

class ProviderResetPasswordPresenter
    with ChangeNotifier
    implements ResetPasswordPresenter {
  // The current state of the login screen
  ResetPasswordState _state;

  final FetchResetPassword _fetchResetPassword;
  final Validation _validation;

  void _validatePassword() {
    final exceptions = _validation.validate(
      field: 'password',
      input: {'password': _state.password},
    );

    if (exceptions.isNotEmpty) {
      _state = _state.copyWith(
        errorMessage:
            'Can not reset password. Please enter your password correctly.',
      );
    }
  }

  void _validateConfirmPassword() {
    if (_state.confirmPassword != _state.password) {
      _state = _state.copyWith(
        errorMessage:
            'Can not reset password. Please enter your password correctly.',
      );
    }
  }

  void _validateForm() {
    _state = _state.copyWith(
      isFormValid: _state.password != null &&
          _state.password!.isNotEmpty &&
          _state.confirmPassword != null &&
          _state.confirmPassword!.isNotEmpty,
    );
    notifyListeners();
  }

  @override
  void setPassword(String? password) {
    // Update the state with the new password
    _state = _state.copyWith(password: password?.trim());
    _validateForm();
  }

  @override
  void resetPassword({required String email}) async {
    if (!_state.isFormValid || _state.isLoading) {
      return;
    }

    _state = _state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    _validatePassword();
    _validateConfirmPassword();

    if (_state.errorMessage != null) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: _state.errorMessage,
      );
      notifyListeners();
      return;
    }

    try {
      final resetPasswordParams = ResetPasswordParams(
        email: email,
        password: _state.password ?? '',
      );
      await _fetchResetPassword.call(params: resetPasswordParams);

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: '/login',
      );
      notifyListeners();
    } on HttpException catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      notifyListeners();
    } catch (_) {
      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  ProviderResetPasswordPresenter({
    required ResetPasswordState state,
    required Validation validation,
    required FetchResetPassword fetchResetPassword,
  })  : _state = state,
        _validation = validation,
        _fetchResetPassword = fetchResetPassword;

  @override
  bool get isLoading => _state.isLoading;

  @override
  String? get navigateTo => _state.navigateTo;

  @override
  bool get isValidForm => _state.isFormValid;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  void toggleShowPassword() {
    _state = _state.copyWith(isShowPassword: !_state.isShowPassword);
    notifyListeners();
  }

  @override
  bool get isShowPassword => _state.isShowPassword;

  @override
  bool get isShowConfirmPassword => _state.isShowConfirmPassword;

  @override
  void setConfirmPassword(String? value) {
    _state = _state.copyWith(confirmPassword: value?.trim());
    _validateForm();
  }

  @override
  void toggleShowConfirmPassword() {
    _state =
        _state.copyWith(isShowConfirmPassword: !_state.isShowConfirmPassword);
    notifyListeners();
  }
}
