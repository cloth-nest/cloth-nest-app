enum SignupRedirect { home, homeAuth, termOfUse }

class SignupState {
  final String? loginId; // The user's email or skype id
  final String? password; // The user's password
  final bool
      isShowPassword; // Whether the password field is currently displayed in plain text or hidden
  final bool isFormValid; // Whether the login form is currently valid
  final bool isLoading; // Whether the login request is currently in progress
  final String?
      errorMessage; // The error message, if any, to display to the user
  final SignupRedirect?
      navigateTo; // Where to navigate to after a successful login

  SignupState({
    required this.loginId,
    required this.password,
    required this.isShowPassword,
    required this.isFormValid,
    required this.isLoading,
    required this.errorMessage,
    required this.navigateTo,
  });

  // Define a factory method to create the initial state of the login screen
  factory SignupState.initial() {
    return SignupState(
      loginId: null,
      password: null,
      isShowPassword: false,
      isFormValid: false,
      isLoading: false,
      errorMessage: null,
      navigateTo: null,
    );
  }

  // Define a method to create a new SignupState object with updated properties
  SignupState copyWith({
    String? loginId,
    String? password,
    bool? isShowPassword,
    bool? isFormValid,
    bool? isLoading,
    String? errorMessage,
    SignupRedirect? navigateTo,
  }) {
    return SignupState(
      loginId: loginId ?? this.loginId,
      password: password ?? this.password,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }
}
