import 'package:ecommerce/app/factories/presentation/account/account_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/address/address_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/authentication/authentication_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/cart/cart_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/cart/cart_view_factory.dart';
import 'package:ecommerce/app/factories/presentation/content_master/content_master_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/my_list/my_list_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/app/factories/presentation/search_shared/search_shared_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/verify_email/verify_email_presenter_factory.dart';
import 'package:ecommerce/presentation/presenters/accessibility/accessibility_presenter.dart';
import 'package:ecommerce/presentation/presenters/main/provider_main_presenter.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:ecommerce/presentation/screens/address/address_presenter.dart';
import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/search_shared/search_shared_presenter.dart';
import 'package:ecommerce/presentation/screens/verify_email/verify_email_presenter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

MainPresenter makeMainPresenter() => ProviderMainPresenter();

List<SingleChildWidget> makeMainPresenters(
  AccessibilityPresenter accessibilityPresenter,
) {
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
    ),
    ChangeNotifierProvider<ProductDetailPresenter>(
      create: (_) => makeProductDetailPresenter(),
    ),
    ChangeNotifierProvider<MyListPresenter>(
      create: (_) => makeMyListPresenter(),
    ),
    ChangeNotifierProvider<SearchSharedPresenter>(
      create: (_) => makeSearchSharedPresenter(),
    ),
    ChangeNotifierProvider<CartPresenter>(
      create: (_) => makeCartPresenter(),
      child: makeCartView(),
    ),
    ChangeNotifierProvider<AccessibilityPresenter>(
      create: (_) => accessibilityPresenter,
    ),
  ];
}
