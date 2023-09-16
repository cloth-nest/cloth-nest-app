import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
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

  void _onListener() {}

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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: size.height,
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          /// TODO: add logic
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: heightInputField,
                      child: PasswordTextField(
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
                          /// TODO: add logic
                        },
                        isObscureText: false,
                        suffixIconPath: SvgPaths.iconEyeOpen,
                        onSuffixIconClicked: () {
                          /// TODO: widget.presenter.toggleShowPassword
                        },
                        textInputAction: TextInputAction.done,
                      ),
                    ),
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
                          // widget.presenter
                          //     .login(widget.authHeader);
                        },
                        customTextStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        isActive: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Selector<LoginPresenter, bool>(
              selector: (context, presenter) => false,
              builder: (context, value, _) {
                if (value) {
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
