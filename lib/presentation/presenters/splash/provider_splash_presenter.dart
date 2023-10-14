import 'package:ecommerce/presentation/screens/splash/splash_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSplashPresenter extends SplashPresenter with ChangeNotifier {
  String _navigateTo = '';

  @override
  void findNextRoute() {
    /// TODO: check authorized or not here
    _navigateTo = '/home';
    notifyListeners();
  }

  @override
  String get navigateTo => _navigateTo;
}
