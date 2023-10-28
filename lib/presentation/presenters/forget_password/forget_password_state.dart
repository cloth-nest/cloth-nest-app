// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForgetPasswordState {
  final bool isLoading;
  final String? errorMessage;
  final String? navigateTo;
  final bool isFormValid;
  final String email;

  ForgetPasswordState({
    required this.isLoading,
    this.errorMessage,
    this.navigateTo,
    required this.isFormValid,
    required this.email,
  });

  factory ForgetPasswordState.initial() {
    return ForgetPasswordState(
      isLoading: false,
      isFormValid: false,
      email: '',
    );
  }

  ForgetPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? navigateTo,
    bool? isFormValid,
    String? email,
  }) {
    return ForgetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      navigateTo: navigateTo,
      isFormValid: isFormValid ?? this.isFormValid,
      email: email ?? this.email,
    );
  }
}
