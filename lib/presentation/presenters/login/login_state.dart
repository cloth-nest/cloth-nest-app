// Define the possible values for the "remember me" checkbox
enum RememberChoice { remember, forget }

// Define the possible values for the login type (guest or authenticated)
enum LoginType { guest, auth }

// Define the possible destinations after a successful login
enum LoginRedirect { home, homeAuth, verifyEmail, signUp, forgetPassword }

class LoginState {
  final String? loginId; // The user's email or skype id
  final String? password; // The user's password
  final RememberChoice
      rememberChoice; // Whether to remember the user's credentials
  final LoginType
      loginType; // Whether the user is logging in as a skip login or authenticated user
  final bool
      isShowPassword; // Whether the password field is currently displayed in plain text or hidden
  final bool isFormValid; // Whether the login form is currently valid
  final bool isLoading; // Whether the login request is currently in progress
  final String?
      errorMessage; // The error message, if any, to display to the user
  final LoginRedirect?
      navigateTo; // Where to navigate to after a successful login

  LoginState({
    required this.loginId,
    required this.password,
    required this.rememberChoice,
    required this.loginType,
    required this.isShowPassword,
    required this.isFormValid,
    required this.isLoading,
    required this.errorMessage,
    required this.navigateTo,
  });

  // Define a factory method to create the initial state of the login screen
  factory LoginState.initial() {
    return LoginState(
      loginId: null,
      password: null,
      rememberChoice: RememberChoice.remember,
      loginType: LoginType.auth,
      isShowPassword: false,
      isFormValid: false,
      isLoading: false,
      errorMessage: null,
      navigateTo: null,
    );
  }

  // Define a method to create a new LoginState object with updated properties
  LoginState copyWith({
    String? loginId,
    String? password,
    RememberChoice? rememberChoice,
    LoginType? loginType,
    bool? isShowPassword,
    bool? isFormValid,
    bool? isLoading,
    String? errorMessage,
    LoginRedirect? navigateTo,
  }) {
    return LoginState(
      loginId: loginId ?? this.loginId,
      password: password ?? this.password,
      rememberChoice: rememberChoice ?? this.rememberChoice,
      loginType: loginType ?? this.loginType,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }
}
