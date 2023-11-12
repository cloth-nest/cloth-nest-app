import 'package:ecommerce/app/factories/presentation/account/account_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/address/address_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/authentication/authentication_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/content_master/content_master_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/verify_email/verify_email_presenter_factory.dart';
import 'package:ecommerce/presentation/presenters/main/provider_main_presenter.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:ecommerce/presentation/screens/address/address_presenter.dart';
import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_presenter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

MainPresenter makeMainPresenter() => ProviderMainPresenter();

List<SingleChildWidget> makeMainPresenters() {
  return [
    ChangeNotifierProvider<MainPresenter>(
      create: (_) => makeMainPresenter(),
    ),
    ChangeNotifierProvider<ContentMasterPresenter>(
      create: (_) => makeContentMasterPresenter(),
    ),
    ChangeNotifierProvider<VerifyEmailPresenter>(
      create: (context) => makeVerifyEmailPresenter(),
    ),
    ChangeNotifierProvider<AccountPresenter>(
      create: (_) => makeAccountPresenter(),
    ),
    ChangeNotifierProvider<AuthenticationPresenter>(
      create: (_) => makeAuthenticationPresenter(),
    ),
    ChangeNotifierProvider<AddressPresenter>(
      create: (_) => makeAddressPresenter(),
    )
  ];
}
