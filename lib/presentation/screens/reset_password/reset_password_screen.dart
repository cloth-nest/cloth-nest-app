import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/reset_password/reset_password_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late ResetPasswordPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<ResetPasswordPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    String? errorMessage = _presenter.errorMessage;
    String? navigateTo = _presenter.navigateTo;

    if (errorMessage != null) {
      showCustomDialog(context, 'Reset Password Failed', errorMessage);
    }

    if (navigateTo != null) {
      context.beamToReplacementNamed(navigateTo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPaddingSubmitButton = size.width * (75 / 390);
    const double heightInputField = 50.0;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: SvgPicture.asset(
              SvgPaths.iconArrowLeft,
            ),
            onPressed: () {
              if (context.canPopBeamLocation) {
                context.popBeamLocation();
              }
            },
          ),
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textLightBasic,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reset Password',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Please enter your new password to reset password',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: heightInputField,
                        child: Selector<ResetPasswordPresenter, bool>(
                          selector: (_, presenter) => presenter.isShowPassword,
                          builder: (_, isShowPassword, __) => PasswordTextField(
                            controller: passwordController,
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
                              _presenter.setPassword(value);
                            },
                            isObscureText: !isShowPassword,
                            suffixIconPath: isShowPassword
                                ? SvgPaths.iconEyeOpen
                                : SvgPaths.iconEyeCrossed,
                            onSuffixIconClicked: () {
                              _presenter.toggleShowPassword();
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: heightInputField,
                        child: Selector<ResetPasswordPresenter, bool>(
                          selector: (_, presenter) =>
                              presenter.isShowConfirmPassword,
                          builder: (_, isShowConfirmPassword, __) =>
                              PasswordTextField(
                            controller: confirmPasswordController,
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
                              _presenter.setConfirmPassword(value);
                            },
                            isObscureText: !isShowConfirmPassword,
                            suffixIconPath: isShowConfirmPassword
                                ? SvgPaths.iconEyeOpen
                                : SvgPaths.iconEyeCrossed,
                            onSuffixIconClicked: () {
                              _presenter.toggleShowConfirmPassword();
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18,
                          left: horizontalPaddingSubmitButton,
                          right: horizontalPaddingSubmitButton,
                          bottom: 0,
                        ),
                        child: Selector<ResetPasswordPresenter, bool>(
                          selector: (_, presenter) => presenter.isValidForm,
                          builder: (_, isFormValid, __) => BRoundButton(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 11),
                            buttonName: 'Reset Password',
                            onClick: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _presenter.resetPassword(
                                email: widget.email,
                              );
                            },
                            customTextStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                            isActive: isFormValid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Selector<ResetPasswordPresenter, bool>(
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
      ),
    );
  }
}
