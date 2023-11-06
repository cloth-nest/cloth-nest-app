import 'package:ecommerce/presentation/presenters/splash/provider_splash_presenter.dart';
import 'package:flutter/material.dart';

abstract class SplashPresenter implements ChangeNotifier {
  void findNextRoute();

  SplashRedirectTo? get navigateTo;
}
