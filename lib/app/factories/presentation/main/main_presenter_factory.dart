import 'package:ecommerce/app/factories/presentation/content_master/content_master_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/login/login_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/splash/splash_presenter_factory.dart';
import 'package:ecommerce/presentation/presenters/main/provider_main_presenter.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/screens/splash/splash_presenter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

MainPresenter makeMainPresenter() => ProviderMainPresenter();

List<SingleChildWidget> makeMainPresenters() {
  return [
    ChangeNotifierProvider<MainPresenter>(
      create: (_) => makeMainPresenter(),
    ),
    ChangeNotifierProvider<LoginPresenter>(
      create: (_) => makeLoginPresenter(),
    ),
    ChangeNotifierProvider<SplashPresenter>(
      create: (_) => makeSplashPresenter(),
    ),
    ChangeNotifierProvider<ContentMasterPresenter>(
      create: (_) => makeContentMasterPresenter(),
    ),
  ];
}
