import 'package:ecommerce/app/factories/presentation/login/login_presenter_factory.dart';
import 'package:ecommerce/presentation/presenters/main/provider_main_presenter.dart';
import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
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
  ];
}
