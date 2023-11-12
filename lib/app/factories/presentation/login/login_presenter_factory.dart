import 'package:ecommerce/app/builders/validation_builder.dart';
import 'package:ecommerce/app/composites/validation_composite.dart';
import 'package:ecommerce/app/factories/presentation/authentication/authentication_presenter_factory.dart';
import 'package:ecommerce/app/factories/usecases/authentication/login/login_factory.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/presenters/login/provider_login_presenter.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';

LoginPresenter makeLoginPresenter() {
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
        .halfWidthSymbol()
        .length(minLengthPass, maxLengthPassword)
        .build(),
  ]);

  return ProviderLoginPresenter(
    state: LoginState.initial(),
    fetchLogin: makeFetchLogin(),
    saveToken: makeSaveLocalToken(),
    validation: validation,
    authenticationPresenter: makeAuthenticationPresenter(),
  );
}
