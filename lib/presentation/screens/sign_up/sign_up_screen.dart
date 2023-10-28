import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/presenters/sign_up/sign_up_state.dart';
import 'package:ecommerce/presentation/screens/sign_up/sign_up_presenter.dart';
import 'package:ecommerce/presentation/screens/sign_up/widgets/login_button.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_screen.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:ecommerce/presentation/widgets/text_field/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final SignUpPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<SignUpPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    SignUpRedirect? navigateTo = _presenter.navigateTo;
    String? errorMessage = _presenter.errorMessage;

    if (errorMessage != null) {
      showErrorDialog(context, 'Sign Up Failed', errorMessage);
    }

    if (navigateTo != null) {
      switch (_presenter.navigateTo) {
        case SignUpRedirect.verifyEmail:
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
        case SignUpRedirect.login:
          context.beamToReplacementNamed('/login');
          break;

        default:
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
    _presenter.resetState();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScreen(
      presenter: _presenter,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final SignUpPresenter presenter;

  const SignUpScreen({
    super.key,
    required this.presenter,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    firstNameController.dispose();
    firstNameFocusNode.dispose();
    lastNameController.dispose();
    lastNameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double horizontalPaddingSubmitButton = size.width * (75 / 390);
    const double heightInputField = 50.0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
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
                    SizedBox(
                      height: heightInputField,
                      child: NormalTextField(
                        controller: firstNameController,
                        focusNode: firstNameFocusNode,
                        nextFocus: lastNameFocusNode,
                        placeHolder: LocaleKeys.firstNameInputText.tr(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 10),
                          child: SvgPicture.asset(
                            SvgPaths.iconUserId,
                          ),
                        ),
                        onChanged: (String? value) {
                          widget.presenter.setFirstName(value!);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: heightInputField,
                      child: NormalTextField(
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
                        nextFocus: emailFocusNode,
                        placeHolder: LocaleKeys.lastNameInputText.tr(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 10),
                          child: SvgPicture.asset(
                            SvgPaths.iconUserId,
                          ),
                        ),
                        onChanged: (String? value) {
                          widget.presenter.setLastName(value!);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
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
                      child: Selector<SignUpPresenter, bool>(
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        left: horizontalPaddingSubmitButton,
                        right: horizontalPaddingSubmitButton,
                        bottom: 0,
                      ),
                      child: Selector<SignUpPresenter, bool>(
                        selector: (_, presenter) => presenter.isFormValid,
                        builder: (_, isActive, __) => BRoundButton(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          buttonName: LocaleKeys.signUpButtonText.tr(),
                          onClick: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            widget.presenter.signUp();
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
                    LoginButton(onClick: widget.presenter.navigateToLoginScreen)
                  ],
                ),
              ),
            ),
            Selector<SignUpPresenter, bool>(
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
