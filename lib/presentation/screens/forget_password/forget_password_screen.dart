import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/forget_password/forget_password_presenter.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_screen.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  late ForgetPasswordPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<ForgetPasswordPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    String? errorMessage = _presenter.errorMessage;
    String? navigateTo = _presenter.navigateTo;

    if (errorMessage != null) {
      showErrorDialog(context, 'Forget Password Failed', errorMessage);
    }

    if (navigateTo != null) {
      showRoundedBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: false,
        radius: 10,
        backgroundColor: Colors.transparent,
        child: VerifyEmailScreen(
          email: _presenter.email,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
          'Forget Password',
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reset Password',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Please enter your email address to reset password',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: heightInputField,
                        child: NormalTextField(
                          controller: emailController,
                          placeHolder: LocaleKeys.emailInputText.tr(),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 10),
                            child: SvgPicture.asset(
                              SvgPaths.iconUserId,
                            ),
                          ),
                          onChanged: (String? value) {
                            _presenter.setEmail(value);
                          },
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
                        child: Selector<ForgetPasswordPresenter, bool>(
                          selector: (_, presenter) => presenter.isFormValid,
                          builder: (_, isFormValid, __) => BRoundButton(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 11),
                            buttonName: 'Send',
                            onClick: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _presenter.send();
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
              Selector<ForgetPasswordPresenter, bool>(
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
