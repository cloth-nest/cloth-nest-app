import 'package:ecommerce/presentation/presenters/authentication/provider_authentication_presenter.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationPresenter implements ChangeNotifier {
  AuthenticatedState get authenticatedState;
  void changeAuthenticatedState(AuthenticatedState newState);
}
