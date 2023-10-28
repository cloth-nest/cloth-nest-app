import 'package:ecommerce/data/http/exceptions/http_exception.dart';
import 'package:ecommerce/domain/usecases/authentication/resend_code/fetch_resend_code.dart';
import 'package:ecommerce/domain/usecases/authentication/resend_code/resend_code_params.dart';
import 'package:ecommerce/domain/usecases/authentication/verify_email/fetch_verify_email.dart';
import 'package:ecommerce/domain/usecases/authentication/verify_email/verify_email_params.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';
import 'package:ecommerce/presentation/presenters/verify_email/verify_email_state.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_presenter.dart';
import 'package:flutter/material.dart';

class ProviderVerifyEmailPresenter
    with ChangeNotifier
    implements VerifyEmailPresenter {
  VerifyEmailState _state;
  final FetchVerifyEmail _fetchVerifyEmail;
  final FetchResendCode _fetchResendCode;
  final FetchVerifyEmail _fetchVerifyEmailForgetPassword;
  final SaveToken _saveToken;

  ProviderVerifyEmailPresenter({
    required VerifyEmailState state,
    required FetchVerifyEmail fetchVerifyEmail,
    required FetchResendCode fetchResendCode,
    required SaveToken saveToken,
    required FetchVerifyEmail fetchVerifyEmailForgetPassword,
  })  : _state = state,
        _fetchVerifyEmail = fetchVerifyEmail,
        _fetchResendCode = fetchResendCode,
        _saveToken = saveToken,
        _fetchVerifyEmailForgetPassword = fetchVerifyEmailForgetPassword;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  bool get isLoading => _state.isLoading;

  @override
  void verifyEmail(String email, bool isFromForgetPassword) async {
    if (_state.isFormValid == false) return;

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final params = VerifyEmailParams(
        email: email,
        code: _state.otpCode,
      );

      if (isFromForgetPassword) {
        await _fetchVerifyEmailForgetPassword.call(params: params);

        _state = _state.copyWith(
          navigateTo: VerifyEmailRedirect.resetPassword,
          isLoading: false,
        );
        notifyListeners();
      } else {
        final tokenEntity = await _fetchVerifyEmail.call(params: params);

        await _saveToken.call(tokenEntity: tokenEntity!);

        _state = _state.copyWith(
          navigateTo: VerifyEmailRedirect.homeAuth,
          isLoading: false,
        );
        notifyListeners();
      }
    } on HttpException catch (_) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'The authentication code is no longer valid or valid',
        controller: TextEditingController(),
        otpCode: '',
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        controller: TextEditingController(),
        otpCode: '',
      );
      notifyListeners();
    }
  }

  @override
  bool get isFormValid => _state.isFormValid;

  @override
  VerifyEmailRedirect? get navigateTo => _state.navigateTo;

  @override
  void resendCode(String email) async {
    try {
      await _fetchResendCode.call(
        params: ResendCodeParams(email: email),
      );
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
      );
      notifyListeners();
    }
  }

  @override
  void setOtpCode(String value) {
    _state = _state.copyWith(otpCode: _state.otpCode + value);
    _validateForm();
  }

  void _validateForm() {
    String otpCode = _state.otpCode;

    if (otpCode.isNotEmpty && otpCode.length == 4) {
      _state = _state.copyWith(
        isFormValid: true,
      );
    } else {
      _state = _state.copyWith(
        isFormValid: false,
      );
    }
  }

  @override
  String get otpCode => _state.otpCode;

  @override
  void resetState() {
    _state = VerifyEmailState.initial();
  }

  @override
  TextEditingController get controller => _state.controller;
}
