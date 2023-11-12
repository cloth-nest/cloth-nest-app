import 'package:ecommerce/presentation/presenters/authentication/provider_authentication_presenter.dart';
import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';

AuthenticationPresenter makeAuthenticationPresenter() =>
    ProviderAuthenticationPresenter(
      state: AuthenticatedState.guest,
    );
