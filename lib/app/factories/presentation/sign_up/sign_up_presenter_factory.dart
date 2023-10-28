import 'package:ecommerce/app/builders/validation_builder.dart';
import 'package:ecommerce/app/composites/validation_composite.dart';
import 'package:ecommerce/app/factories/usecases/authentication/sign_up/sign_up_factory.dart';
import 'package:ecommerce/presentation/presenters/sign_up/provider_sign_up_presenter.dart';
import 'package:ecommerce/presentation/presenters/sign_up/sign_up_state.dart';
import 'package:ecommerce/presentation/screens/sign_up/sign_up_presenter.dart';

SignUpPresenter makeSignUpPresenter() {
  const fieldLoginId = 'loginId';
  const fieldPassword = 'password';
  const maxLengthLoginId = 81;
  const maxLengthPassword = 33;
  const minLengthId = 0;
  const minLengthPass = 7;
  final validation = ValidationComposite([
    ...ValidationBuilder.field(fieldLoginId)
        .email()
        .length(minLengthId, maxLengthLoginId)
        .build(),
    ...ValidationBuilder.field(fieldPassword)
        .length(minLengthPass, maxLengthPassword)
        .halfWidthSymbol()
        .build(),
  ]);

  return ProviderSignUpPresenter(
    state: SignUpState.initial(),
    validation: validation,
    fetchSignUp: makeFetchSignUp(),
  );
}
