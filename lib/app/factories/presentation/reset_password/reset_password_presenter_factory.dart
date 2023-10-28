import 'package:ecommerce/app/builders/validation_builder.dart';
import 'package:ecommerce/app/composites/validation_composite.dart';
import 'package:ecommerce/app/factories/usecases/authentication/reset_password/reset_password_factory.dart';
import 'package:ecommerce/presentation/presenters/reset_password/provider_reset_password_presenter.dart';
import 'package:ecommerce/presentation/presenters/reset_password/reset_password_state.dart';
import 'package:ecommerce/presentation/screens/reset_password/reset_password_presenter.dart';

ResetPasswordPresenter makeResetPasswordPresenter() {
  const fieldPassword = 'password';
  const maxLengthPassword = 33;
  const minLengthPass = 7;
  final validation = ValidationComposite([
    ...ValidationBuilder.field(fieldPassword)
        .halfWidthSymbol()
        .length(minLengthPass, maxLengthPassword)
        .build(),
  ]);

  return ProviderResetPasswordPresenter(
    state: ResetPasswordState.initial(),
    validation: validation,
    fetchResetPassword: makeFetchResetPassword(),
  );
}
