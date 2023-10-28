import 'package:ecommerce/app/factories/usecases/profile/profile_factory.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/fetch_logout.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/logout_params.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:ecommerce/presentation/presenters/account/account_state.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:flutter/material.dart';

class ProviderAccountPresenter with ChangeNotifier implements AccountPresenter {
  AccountState _state;

  final FetchToken _fetchToken;
  final FetchLogout _fetchRemoteLogout;
  final FetchLogout _fetchLocalLogout;

  ProviderAccountPresenter(
      {required AccountState state,
      required FetchToken fetchToken,
      required FetchLogout fetchRemoteLogout,
      required FetchLogout fetchLocalLogout})
      : _state = state,
        _fetchToken = fetchToken,
        _fetchRemoteLogout = fetchRemoteLogout,
        _fetchLocalLogout = fetchLocalLogout;

  @override
  bool get isLoading => _state.isLoading;

  @override
  void logout() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    try {
      final TokenEntity? token =
          await _fetchToken.call(key: uniqueUserTokenKey);

      await _fetchRemoteLogout.call(
        params: LogoutParams(
          refreshToken: token?.refreshToken ?? '',
        ),
      );

      await _fetchLocalLogout.call();

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: '/login',
      );
      notifyListeners();
    } catch (_) {
      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  @override
  String? get navigateTo => _state.navigateTo;

  @override
  void testAutoLogin() async {
    try {
      final fetchProfile = makeFetchProfile();
      await fetchProfile.call();
    } catch (_) {}
  }
}
