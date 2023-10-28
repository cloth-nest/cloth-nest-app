enum SignUpRedirect { login, verifyEmail }

class SignUpState {
  final String? firstName;
  final String? lastName;
  final String? loginId; // The user's email or skype id
  final String? password; // The user's password
  final bool
      isShowPassword; // Whether the password field is currently displayed in plain text or hidden
  final bool isFormValid; // Whether the login form is currently valid
  final bool isLoading; // Whether the login request is currently in progress
  final String?
      errorMessage; // The error message, if any, to display to the user
  final SignUpRedirect?
      navigateTo; // Where to navigate to after a successful login

  SignUpState(
      {required this.loginId,
      required this.password,
      required this.isShowPassword,
      required this.isFormValid,
      required this.isLoading,
      required this.errorMessage,
      required this.navigateTo,
      required this.firstName,
      required this.lastName});

  // Define a factory method to create the initial state of the login screen
  factory SignUpState.initial() {
    return SignUpState(
      loginId: null,
      password: null,
      isShowPassword: false,
      isFormValid: false,
      isLoading: false,
      errorMessage: null,
      firstName: null,
      lastName: null,
      navigateTo: null,
    );
  }

  // Define a method to create a new SignupState object with updated properties
  SignUpState copyWith({
    String? loginId,
    String? password,
    bool? isShowPassword,
    bool? isFormValid,
    bool? isLoading,
    String? errorMessage,
    SignUpRedirect? navigateTo,
    String? firstName,
    String? lastName,
  }) {
    return SignUpState(
        loginId: loginId ?? this.loginId,
        password: password ?? this.password,
        isShowPassword: isShowPassword ?? this.isShowPassword,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        navigateTo: navigateTo ?? this.navigateTo,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName);
  }
}
