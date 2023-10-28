import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/presenters/verify_email/verify_email_state.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_presenter.dart';
import 'package:ecommerce/presentation/screens/verify_email/widgets/resend_code_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;
  final bool? isFromForgetPassword;

  const VerifyEmailScreen({
    super.key,
    this.email,
    this.isFromForgetPassword = false,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  TextEditingController _firstController = TextEditingController();
  TextEditingController _secondController = TextEditingController();
  TextEditingController _thirdController = TextEditingController();
  TextEditingController _fourthController = TextEditingController();

  late VerifyEmailPresenter _presenter;

  @override
  void dispose() {
    super.dispose();
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();

    _presenter.resetState();
    _presenter.removeListener(_onListener);
  }

  @override
  void initState() {
    super.initState();
    _presenter = context.read<VerifyEmailPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    String? errorMessage = _presenter.errorMessage;
    VerifyEmailRedirect? navigateTo = _presenter.navigateTo;

    if (errorMessage != null) {
      setState(() {
        _firstController.clear();
        _secondController.clear();
        _thirdController.clear();
        _fourthController.clear();
      });
      showErrorDialog(
        context,
        'Verify email failed',
        errorMessage,
      );
    }

    if (navigateTo != null) {
      switch (navigateTo) {
        case VerifyEmailRedirect.homeAuth:
          context.beamToReplacementNamed('/home');
          break;
        case VerifyEmailRedirect.resetPassword:
          context.beamToNamed('/reset_password?email=${widget.email}');
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double heightInputField = 68;
    const double widthInputField = 64;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: AppColors.white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 25),
              Text(
                'Verify Code',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'An verification code included 4 numbers has been sent to email ${widget.email}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 60),
              Text(
                'Enter code to continue',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: widthInputField,
                    height: heightInputField,
                    child: OtpTextField(
                      controller: _firstController,
                      placeHolder: '',
                      autoFocus: true,
                      onChanged: (String? value) {
                        if (value?.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        _presenter.setOtpCode(value ?? '');
                        _presenter.verifyEmail(
                          widget.email ?? '',
                          widget.isFromForgetPassword ?? false,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: widthInputField,
                    height: heightInputField,
                    child: OtpTextField(
                      controller: _secondController,
                      placeHolder: '',
                      autoFocus: false,
                      onChanged: (String? value) {
                        if (value?.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        _presenter.setOtpCode(value ?? '');
                        _presenter.verifyEmail(
                          widget.email ?? '',
                          widget.isFromForgetPassword ?? false,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: widthInputField,
                    height: heightInputField,
                    child: OtpTextField(
                      controller: _thirdController,
                      placeHolder: '',
                      autoFocus: false,
                      onChanged: (String? value) {
                        if (value?.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        _presenter.setOtpCode(value ?? '');
                        _presenter.verifyEmail(
                          widget.email ?? '',
                          widget.isFromForgetPassword ?? false,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: widthInputField,
                    height: heightInputField,
                    child: OtpTextField(
                      controller: _fourthController,
                      placeHolder: '',
                      autoFocus: false,
                      onChanged: (String? value) {
                        if (value?.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        _presenter.setOtpCode(value ?? '');
                        _presenter.verifyEmail(
                          widget.email ?? '',
                          widget.isFromForgetPassword ?? false,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: Platform.isIOS ? 20 : 23),
              ResendCodeButton(onClick: () {
                _presenter.resendCode(widget.email ?? '');
              }),
              const SizedBox(height: 20),
            ],
          ),
          Selector<VerifyEmailPresenter, bool>(
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
    );
  }
}
