import 'package:ecommerce/app/factories/usecases/authentication/resend_code/resend_code_factory.dart';
import 'package:ecommerce/app/factories/usecases/authentication/verify_email/verify_email_factory.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/presentation/presenters/verify_email/provider_verify_email_presenter.dart';
import 'package:ecommerce/presentation/presenters/verify_email/verify_email_state.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_presenter.dart';

VerifyEmailPresenter makeVerifyEmailPresenter() => ProviderVerifyEmailPresenter(
      state: VerifyEmailState.initial(),
      fetchVerifyEmail: makeFetchVerifyEmail(),
      fetchResendCode: makeFetchResendCode(),
      saveToken: makeSaveLocalToken(),
      fetchVerifyEmailForgetPassword: makeFetchVerifyEmailForgetPassword(),
    );
