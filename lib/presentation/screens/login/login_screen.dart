import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/presenters/authentication/provider_authentication_presenter.dart';
import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:ecommerce/presentation/screens/login/widgets/auto_login_button.dart';
import 'package:ecommerce/presentation/screens/login/widgets/forget_password_button.dart';
import 'package:ecommerce/presentation/screens/login/widgets/login_guest_button.dart';
import 'package:ecommerce/presentation/screens/login/widgets/sign_up_button.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_screen.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:ecommerce/presentation/widgets/text_field/password_text_field.dart';
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
    LoginRedirect? navigateTo = _presenter.navigateTo;
    String? errorMessage = _presenter.errorMessage;

    if (errorMessage != null) {
      showCustomDialog(context, 'Login Failed', errorMessage);
    }

    if (navigateTo != null) {
      switch (_presenter.navigateTo) {
        case LoginRedirect.homeAuth:
          context
              .read<AuthenticationPresenter>()
              .changeAuthenticatedState(AuthenticatedState.authorized);
          context.beamToReplacementNamed('/home');
          break;
        case LoginRedirect.home:
          context
              .read<AuthenticationPresenter>()
              .changeAuthenticatedState(AuthenticatedState.guest);
          context.beamToReplacementNamed('/home');
          break;
        case LoginRedirect.signUp:
          context.beamToReplacementNamed('/sign_up');
          break;
        case LoginRedirect.forgetPassword:
          context.beamToNamed('/forget_password');
          break;
        case LoginRedirect.verifyEmail:
          showRoundedBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: false,
            radius: 10,
            backgroundColor: Colors.transparent,
            child: VerifyEmailScreen(
              email: _presenter.loginId,
            ),
          );
          break;
        default:
      }
    }
  }

  @override
  void dispose() {
    _presenter.removeListener(_onListener);
    _presenter.resetState();
    super.dispose();
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
    const double heightInputField = 50.0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                    SizedBox(
                      height: heightInputField,
                      child: NormalTextField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        nextFocus: passwordFocusNode,
                        placeHolder: LocaleKeys.emailInputText.tr(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 10),
                          child: SvgPicture.asset(
                            SvgPaths.iconUserId,
                          ),
                        ),
                        onChanged: (String? value) {
                          widget.presenter.setLoginId(value!);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: heightInputField,
                      child: Selector<LoginPresenter, bool>(
                        selector: (_, presenter) => presenter.isShowPassword,
                        builder: (_, isShowPassword, __) => PasswordTextField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          placeHolder: LocaleKeys.passwordInputText.tr(),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 10,
                            ),
                            child: SvgPicture.asset(
                              SvgPaths.iconPassword,
                            ),
                          ),
                          onChanged: (String? value) {
                            widget.presenter.setPassword(value!);
                          },
                          isObscureText: !isShowPassword,
                          suffixIconPath: isShowPassword
                              ? SvgPaths.iconEyeOpen
                              : SvgPaths.iconEyeCrossed,
                          onSuffixIconClicked: () {
                            widget.presenter.toggleShowPassword();
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                    SizedBox(height: Platform.isIOS ? 2 : 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Selector<LoginPresenter, RememberChoice>(
                          selector: (_, presenter) => presenter.rememberChoice,
                          builder: (context, value, _) {
                            return AutoLoginButton(
                              iconPath: value == RememberChoice.remember
                                  ? SvgPaths.iconSelect
                                  : SvgPaths.iconUnselect,
                              onClick: widget.presenter.toggleAutoLogin,
                            );
                          },
                        ),
                        ForgetPasswordButton(onClick: () {
                          widget.presenter.navigateToForgetPasswordScreen();
                        }),
                      ],
                    ),
                    SizedBox(height: Platform.isIOS ? 13 : 17),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        left: horizontalPaddingSubmitButton,
                        right: horizontalPaddingSubmitButton,
                        bottom: 0,
                      ),
                      child: Selector<LoginPresenter, bool>(
                        selector: (_, presenter) => presenter.isFormValid,
                        builder: (_, isActive, __) => BRoundButton(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          buttonName: LocaleKeys.loginButtonText.tr(),
                          onClick: () {
                            widget.presenter.login();
                          },
                          customTextStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                          isActive: isActive,
                        ),
                      ),
                    ),
                    SizedBox(height: Platform.isIOS ? 20 : 23),
                    SignUpButton(
                      onClick: () async {
                        widget.presenter.navigateToSignUpScreen();
                      },
                    ),
                    SizedBox(
                      height: Platform.isIOS ? 20 : 23,
                    ),
                    LoginGuestButton(
                      onClick: widget.presenter.loginAsGuest,
                    ),
                  ],
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
