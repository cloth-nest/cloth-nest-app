import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';
import 'package:flutter/material.dart';

enum AuthenticatedState { authorized, guest }

class ProviderAuthenticationPresenter
    with ChangeNotifier
    implements AuthenticationPresenter {
  AuthenticatedState _state;

  ProviderAuthenticationPresenter({
    required AuthenticatedState state,
  }) : _state = state;

  @override
  AuthenticatedState get authenticatedState => _state;

  @override
  void changeAuthenticatedState(AuthenticatedState newState) {
    _state = newState;

    notifyListeners();
  }
}
