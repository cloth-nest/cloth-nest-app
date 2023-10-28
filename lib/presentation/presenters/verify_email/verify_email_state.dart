// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum VerifyEmailRedirect { login, homeAuth }

class VerifyEmailState {
  final bool isFormValid; // Whether the login form is currently valid
  final bool isLoading; // Whether the login request is currently in progress
  final String?
      errorMessage; // The error message, if any, to display to the user
  final VerifyEmailRedirect?
      navigateTo; // Where to navigate to after a successful login
  final String otpCode;
  final TextEditingController controller;

  VerifyEmailState({
    required this.isFormValid,
    required this.isLoading,
    required this.errorMessage,
    required this.navigateTo,
    required this.otpCode,
    required this.controller,
  });

  factory VerifyEmailState.initial() {
    return VerifyEmailState(
      isFormValid: false,
      isLoading: false,
      errorMessage: null,
      navigateTo: null,
      otpCode: '',
      controller: TextEditingController(),
    );
  }
  VerifyEmailState copyWith({
    bool? isFormValid,
    bool? isLoading,
    String? errorMessage,
    VerifyEmailRedirect? navigateTo,
    String? otpCode,
    TextEditingController? controller,
  }) {
    return VerifyEmailState(
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      navigateTo: navigateTo,
      otpCode: otpCode ?? this.otpCode,
      controller: controller ?? this.controller,
    );
  }
}
