import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<LoginPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      switch (_presenter.navigateTo) {
        case LoginRedirect.homeAuth:
          context.beamToReplacementNamed('/home');
          break;
        default:
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
    _presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      presenter: _presenter,
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
    final size = MediaQuery.sizeOf(context);
    final double horizontalPaddingSubmitButton = size.width * (75 / 390);

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
                  height: size.height,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Platform.isIOS ? 14 : 17,
                    bottom: Platform.isIOS ? 34 : 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Center(
                          child: SvgPicture.asset(
                            SvgPaths.iconLogo,
                            width: 100,
                            height: 100,
                          ),
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18,
                          left: horizontalPaddingSubmitButton,
                          right: horizontalPaddingSubmitButton,
                          bottom: 0,
                        ),
                        child: BRoundButton(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          buttonName: LocaleKeys.loginButtonText.tr(),
                          onClick: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            widget.presenter.login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          },
                          customTextStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                          isActive: _isInputValid,
                        ),
                      ),
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
          if (value == null || value.isEmpty) {
            return 'Invalid Password';
          }
          return null;
        });
  }
}
