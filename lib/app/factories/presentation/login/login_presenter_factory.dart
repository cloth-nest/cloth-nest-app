import 'package:ecommerce/presentation/presenters/login/login_state.dart';
import 'package:ecommerce/presentation/presenters/login/provider_login_presenter.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';

LoginPresenter makeLoginPresenter() {
  return ProviderLoginPresenter(state: LoginState.initial());
}
