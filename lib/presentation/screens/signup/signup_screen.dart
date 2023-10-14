import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/presenters/signup/signup_state.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:ecommerce/presentation/screens/login/utils.dart';
import 'package:ecommerce/presentation/screens/signup/signup_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupPresenter _presenter;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  var _isInputValid = false;
  var _shouldRememberLogin = false;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<SignupPresenter>();
    _presenter.addListener(_onListener);

    emailController.addListener(_validateLoginForm);
    passwordController.addListener(_validateLoginForm);
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      switch (_presenter.navigateTo) {
        case SignupRedirect.home:
          //context.beamToReplacementNamed('/home');
          break;
        default:
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _presenter.removeListener(_onListener);
    _presenter.dispose();
  }

  void _validateLoginForm() {
    setState(() {
      _isInputValid = _formKey.currentState!.validate();
    });
  }

  void _signUp() {
    //TODO: Call presenter's signup
    // _presenter.login(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //     rememberLogin: _shouldRememberLogin);
  }

  void _navigateToRegister() {
    // TODO: Implement "Register"
    print('Register');
  }

  void _userForgotPassword() {
    //TODO: Implement "Forgot password"
    print('forgot password');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Stack(
          children: [
            Form(
              key: _formKey,
              onChanged: _validateLoginForm,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Platform.isIOS ? 14 : 17,
                    bottom: Platform.isIOS ? 34 : 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          SvgPaths.iconLogo,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      _EmailTextField(
                          emailController: emailController,
                          emailFocusNode: emailFocusNode,
                          passwordFocusNode: passwordFocusNode),
                      const SizedBox(height: 16),
                      _PasswordTextField(
                          passwordController: passwordController,
                          passwordFocusNode: passwordFocusNode),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text("Remember Me"),
                              value: _shouldRememberLogin,
                              onChanged: (newValue) {
                                setState(() {
                                  _shouldRememberLogin = newValue ?? false;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                            ),
                            onPressed: _userForgotPassword,
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _LoginButton(onClick: _signUp, isActive: _isInputValid),
                      const SizedBox(height: 16),
                      _RegisterText(onRegisterClick: _navigateToRegister),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Selector<LoginPresenter, bool>(
              selector: (context, presenter) => presenter.isLoading,
              builder: (context, isLoading, _) {
                if (isLoading) {
                  return Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginScreen({
    super.key,
    required this.presenter,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _isInputValid = false;
  var _shouldRememberLogin = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateLoginForm);
    passwordController.addListener(_validateLoginForm);
  }

  void _validateLoginForm() {
    setState(() {
      _isInputValid = _formKey.currentState!.validate();
    });
  }

  void _logIn() {
    widget.presenter.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rememberLogin: _shouldRememberLogin);
  }

  void _navigateToRegister() {
    // TODO: Implement "Register"
    print('Register');
  }

  void _userForgotPassword() {
    //TODO: Implement "Forgot password"
    print('forgot password');
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Stack(
          children: [
            Form(
              key: _formKey,
              onChanged: _validateLoginForm,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Platform.isIOS ? 14 : 17,
                    bottom: Platform.isIOS ? 34 : 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          SvgPaths.iconLogo,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      _EmailTextField(
                          emailController: emailController,
                          emailFocusNode: emailFocusNode,
                          passwordFocusNode: passwordFocusNode),
                      const SizedBox(height: 16),
                      _PasswordTextField(
                          passwordController: passwordController,
                          passwordFocusNode: passwordFocusNode),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text("Remember Me"),
                              value: _shouldRememberLogin,
                              onChanged: (newValue) {
                                setState(() {
                                  _shouldRememberLogin = newValue ?? false;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                            ),
                            onPressed: _userForgotPassword,
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _LoginButton(onClick: _logIn, isActive: _isInputValid),
                      const SizedBox(height: 16),
                      _RegisterText(onRegisterClick: _navigateToRegister),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Selector<LoginPresenter, bool>(
              selector: (context, presenter) => presenter.isLoading,
              builder: (context, isLoading, _) {
                if (isLoading) {
                  return Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatefulWidget {
  const _EmailTextField({
    required this.emailController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  @override
  State<_EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<_EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: widget.emailController,
        focusNode: widget.emailFocusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Email',
          hintText: LocaleKeys.emailInputText.tr(),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(SvgPaths.iconUserId),
          ),
        ),
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !EmailValidator.validate(value)) {
            return 'Invalid Email';
          }
          return null;
        });
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.passwordController,
    required this.passwordFocusNode,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  var _isPasswordShown = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordShown = !_isPasswordShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.passwordController,
        focusNode: widget.passwordFocusNode,
        obscureText: !_isPasswordShown,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Password',
          hintText: LocaleKeys.passwordInputText.tr(),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(SvgPaths.iconPassword),
          ),
          suffixIcon: IconButton(
            icon: _isPasswordShown
                ? SvgPicture.asset(
                    SvgPaths.iconEyeCrossed,
                  )
                : SvgPicture.asset(
                    SvgPaths.iconEyeOpen,
                  ),
            onPressed: togglePasswordVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || !value.isValidPassword()) {
            print("value.isValidPassword(): ${value?.isValidPassword()}");
            return """
- Must be at least 8 characters
- Should contain at least 1 number (0-9)
- Should contain at least 1 uppercase letter (A-Z)
- Should contain at least 1 lowercase letter (a-z)
- No special characters allowed
""";
          }
          return null;
        });
  }
}

class _RegisterText extends StatelessWidget {
  final VoidCallback onRegisterClick;

  const _RegisterText({required this.onRegisterClick});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              style: AppThemes.lightTextTheme.bodyLarge,
              text: 'Don\'t have an an account ? '),
          TextSpan(
              text: 'Register',
              // TODO: Centralize TextStyles
              style: TextStyle(
                color: AppThemes.lightTheme.primaryColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = onRegisterClick),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onClick, required this.isActive});

  final VoidCallback onClick;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return BRoundButton(
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      buttonName: LocaleKeys.loginButtonText.tr(),
      onClick: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onClick;
      },
      customTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      isActive: isActive,
    );
  }
}
