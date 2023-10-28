import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/presentation/presenters/splash/provider_splash_presenter.dart';
import 'package:ecommerce/presentation/screens/splash/splash_presenter.dart';

SplashPresenter makeSplashPresenter() => ProviderSplashPresenter(
      fetchToken: makeFetchLocalToken(),
    );
