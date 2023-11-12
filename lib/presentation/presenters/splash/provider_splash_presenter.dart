import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:ecommerce/presentation/screens/splash/splash_presenter.dart';
import 'package:flutter/material.dart';

enum SplashRedirectTo { home, login }

class ProviderSplashPresenter extends SplashPresenter with ChangeNotifier {
  final FetchToken _fetchToken;

  ProviderSplashPresenter({required FetchToken fetchToken})
      : _fetchToken = fetchToken;

  SplashRedirectTo? _navigateTo;

  @override
  void findNextRoute() async {
    final TokenEntity? tokenEntity =
        await _fetchToken.call(key: uniqueUserTokenKey);
    if (tokenEntity == null) {
      _navigateTo = SplashRedirectTo.login;
    } else {
      _navigateTo = SplashRedirectTo.home;
    }
    notifyListeners();
  }

  @override
  SplashRedirectTo? get navigateTo => _navigateTo;
}
