class ResetPasswordState {
  final String? password;
  final String? confirmPassword; // The user's password
  final bool isShowPassword;
  final bool
      isShowConfirmPassword; // Whether the password field is currently displayed in plain text or hidden
  final bool isFormValid; // Whether the login form is currently valid
  final bool isLoading; // Whether the login request is currently in progress
  final String?
      errorMessage; // The error message, if any, to display to the user
  final String? navigateTo; // Where to navigate to after a successful login

  ResetPasswordState({
    required this.password,
    required this.isShowPassword,
    required this.isFormValid,
    required this.isLoading,
    required this.errorMessage,
    required this.navigateTo,
    required this.confirmPassword,
    required this.isShowConfirmPassword,
  });

  // Define a factory method to create the initial state of the login screen
  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      password: null,
      isShowPassword: false,
      isFormValid: false,
      isLoading: false,
      errorMessage: null,
      navigateTo: null,
      confirmPassword: null,
      isShowConfirmPassword: false,
    );
  }

  // Define a method to create a new LoginState object with updated properties
  ResetPasswordState copyWith({
    String? loginId,
    String? password,
    bool? isShowPassword,
    bool? isFormValid,
    bool? isLoading,
    String? errorMessage,
    String? navigateTo,
    String? confirmPassword,
    bool? isShowConfirmPassword,
  }) {
    return ResetPasswordState(
      password: password ?? this.password,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      navigateTo: navigateTo,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isShowConfirmPassword:
          isShowConfirmPassword ?? this.isShowConfirmPassword,
    );
  }
}
