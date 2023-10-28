import 'package:ecommerce/app/builders/validation_builder.dart';
import 'package:ecommerce/app/composites/validation_composite.dart';
import 'package:ecommerce/app/factories/usecases/authentication/forget_password/forget_password_factory.dart';
import 'package:ecommerce/presentation/presenters/forget_password/forget_password_state.dart';
import 'package:ecommerce/presentation/presenters/forget_password/provider_forget_password_presenter.dart';
import 'package:ecommerce/presentation/screens/forget_password/forget_password_presenter.dart';

ForgetPasswordPresenter makeForgetPasswordPresenter() {
  const fieldLoginId = 'loginId';
  const maxLengthLoginId = 81;

  const minLengthId = 0;
  final validation = ValidationComposite([
    ...ValidationBuilder.field(fieldLoginId)
        .email()
        .length(minLengthId, maxLengthLoginId)
        .build(),
  ]);

  return ProviderForgetPasswordPresenter(
    state: ForgetPasswordState.initial(),
    validation: validation,
    fetchForgetPassword: makeRemoteFetchForgetPassword(),
  );
}
