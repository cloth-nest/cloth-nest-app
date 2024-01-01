import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/account/account_add_address_location.dart';
import 'package:ecommerce/app/routes/account/account_address_location.dart';
import 'package:ecommerce/app/routes/account/account_detail_address_location.dart';
import 'package:ecommerce/app/routes/account/account_location.dart';
import 'package:ecommerce/app/routes/account/account_profile_location.dart';
import 'package:ecommerce/app/routes/cart/cart_checkout_location.dart';
import 'package:ecommerce/app/routes/cart/cart_checkout_success_location.dart';
import 'package:ecommerce/app/routes/cart/cart_checkout_success_orders_detail_location.dart';
import 'package:ecommerce/app/routes/cart/cart_checkout_success_orders_location.dart';
import 'package:ecommerce/app/routes/cart/cart_location.dart';
import 'package:ecommerce/app/routes/cart/cart_product_checkout_location.dart';
import 'package:ecommerce/app/routes/cart/cart_product_location.dart';
import 'package:ecommerce/app/routes/my_list/my_list_location.dart';
import 'package:ecommerce/app/routes/my_list/my_list_product_checkout_location.dart';
import 'package:ecommerce/app/routes/my_list/my_list_product_location.dart';
import 'package:ecommerce/app/routes/order/order_detail_location.dart';
import 'package:ecommerce/app/routes/order/order_detail_review_location.dart';
import 'package:ecommerce/app/routes/order/order_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_category_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_category_product_checkout_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_category_product_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_product_checkout_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_product_location.dart';
import 'package:ecommerce/app/routes/search/search_location.dart';
import 'package:ecommerce/app/routes/top/top_category_location.dart';
import 'package:ecommerce/app/routes/top/top_location.dart';
import 'package:ecommerce/app/routes/top/top_product_checkout_location.dart';
import 'package:ecommerce/app/routes/top/top_product_checkout_success_location.dart';
import 'package:ecommerce/app/routes/top/top_product_location.dart';
import 'package:ecommerce/app/routes/top/top_qr_location.dart';
import 'package:ecommerce/app/routes/top/top_qr_product_checkout_location.dart';
import 'package:ecommerce/app/routes/top/top_qr_product_checkout_success_location.dart';
import 'package:ecommerce/app/routes/top/top_qr_product_location.dart';
import 'package:ecommerce/app/routes/top/top_search_detail_location.dart';
import 'package:ecommerce/app/routes/top/top_search_detail_product_checkout_location.dart';
import 'package:ecommerce/app/routes/top/top_search_detail_product_location.dart';
import 'package:ecommerce/presentation/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('home'),
        title: 'home',
        child: MainScreen(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/*'];
}

final homeRouteDelegate = [
  topTabHomeRouteDelegate,
  searchTabHomeRouteDelegate,
  myListTabHomeRouteDelegate,
  cartTabHomeRouteDelegate,
  orderTabHomeRouteDelegate,
  accountTabHomeRouteDelegate,
];

final topTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/top',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!
        .contains('/top/qr_code/product/checkout/success')) {
      return TopQrProductCheckOutSuccessLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/top/qr_code/product/checkout')) {
      return TopQrProductCheckOutLocation(routeInformation);
    } else if (routeInformation.location!.contains('/top/qr_code/product')) {
      return TopQrProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/top/qr_code')) {
      return TopQrLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/top/detail/product/checkout/success')) {
      return TopProductCheckOutSuccessLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/top/detail/product/checkout')) {
      return TopProductCheckOutLocation(routeInformation);
    } else if (routeInformation.location!.contains('/top/detail/product')) {
      return TopProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/top/detail')) {
      return TopCategoryLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/top/search/result/product/checkout')) {
      return TopSearchDetailProductCheckOutLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/top/search/result/product')) {
      return TopSearchDetailProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/top/search/result')) {
      return TopSearchDetailLocation(routeInformation);
    } else if (routeInformation.location!.contains('/top')) {
      return TopLocation(routeInformation);
    }
    return NotFound(path: routeInformation.location!);
  },
);

final searchTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/search',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!
        .contains('/search/result/product/checkout')) {
      return SearchDetailProductCheckOutLocation(routeInformation);
    } else if (routeInformation.location!.contains('/search/result/product')) {
      return SearchDetailProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/search/result')) {
      return SearchDetailLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/search/category_detail/product/checkout')) {
      return SearchDetailCategoryProductCheckoutLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('/search/category_detail/product')) {
      return SearchDetailCategoryProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/search/category_detail')) {
      return SearchDetailCategoryLocation(routeInformation);
    } else if (routeInformation.location!.contains('/search')) {
      return SearchLocation(routeInformation);
    }
    return NotFound(path: routeInformation.location!);
  },
);

final myListTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/my_list',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('my_list/product/checkout')) {
      return MyListProductCheckOutLocation(routeInformation);
    } else if (routeInformation.location!.contains('my_list/product')) {
      return MyListProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/my_list')) {
      return MyListLocation(routeInformation);
    }
    return NotFound(path: routeInformation.location!);
  },
);

final cartTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/cart',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!
        .contains('cart/check_out/success/orders/detail')) {
      return CartCheckOutSuccessOrdersDetailLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('cart/check_out/success/orders/cart')) {
      return CartLocation(routeInformation);
    } else if (routeInformation.location!
        .contains('cart/check_out/success/orders')) {
      return CartCheckOutSuccessOrdersLocation(routeInformation);
    } else if (routeInformation.location!.contains('cart/check_out/success')) {
      return CartCheckOutSuccessLocation(routeInformation);
    } else if (routeInformation.location!.contains('cart/product/checkout')) {
      return CartProductCheckOutLocation(routeInformation);
    } else if (routeInformation.location!.contains('cart/check_out')) {
      return CartCheckOutLocation(routeInformation);
    } else if (routeInformation.location!.contains('cart/product')) {
      return CartProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/cart')) {
      return CartLocation(routeInformation);
    }
    return NotFound(
      path: routeInformation.location!,
    );
  },
);

final orderTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/order',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('/order/detail/review')) {
      return OrderDetailReviewLocation(routeInformation);
    } else if (routeInformation.location!.contains('/order/detail')) {
      return OrderDetailLocation(routeInformation);
    } else if (routeInformation.location!.contains('/order')) {
      return OrderLocation(routeInformation);
    }
    return NotFound();
  },
);

final accountTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/account',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('/account/address/detail')) {
      return AccountDetailAddressLocation(routeInformation);
    } else if (routeInformation.location!.contains('/account/address/add')) {
      return AccountAddAddressLocation(routeInformation);
    } else if (routeInformation.location!.contains('/account/address')) {
      return AccountAddressLocation(routeInformation);
    } else if (routeInformation.location!.contains('/account/profile')) {
      return AccountProfileLocation(routeInformation);
    } else if (routeInformation.location!.contains('/account')) {
      return AccountLocation(routeInformation);
    }
    return NotFound();
  },
);
