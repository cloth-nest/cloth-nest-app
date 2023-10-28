import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:ecommerce/presentation/screens/splash/splash_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSplashPresenter extends SplashPresenter with ChangeNotifier {
  final FetchToken _fetchToken;

  ProviderSplashPresenter({required FetchToken fetchToken})
      : _fetchToken = fetchToken;

  String _navigateTo = '';

  @override
  void findNextRoute() async {
    /// TODO: check authorized or not here
    final TokenEntity? tokenEntity =
        await _fetchToken.call(key: uniqueUserTokenKey);
    if (tokenEntity == null) {
      _navigateTo = '/login';
    } else {
      _navigateTo = '/home';
    }
    notifyListeners();
  }

  @override
  String get navigateTo => _navigateTo;
}
