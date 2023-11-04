import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/account/account_location.dart';
import 'package:ecommerce/app/routes/my_list/my_list_location.dart';
import 'package:ecommerce/app/routes/my_list/my_list_product_location.dart';
import 'package:ecommerce/app/routes/search/search_detail_location.dart';
import 'package:ecommerce/app/routes/search/search_location.dart';
import 'package:ecommerce/app/routes/top/top_location.dart';
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
  notificationTabHomeRouteDelegate,
  accountTabHomeRouteDelegate,
];

final topTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/top',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('/top')) {
      return TopLocation();
    }
    return NotFound(path: routeInformation.location!);
  },
);

final searchTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/search',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('/search/result')) {
      return SearchDetailLocation(routeInformation);
    } else if (routeInformation.location!.contains('/search')) {
      return SearchLocation();
    }
    return NotFound(path: routeInformation.location!);
  },
);

final myListTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/my_list',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('my_list/product')) {
      return MyListProductLocation(routeInformation);
    } else if (routeInformation.location!.contains('/my_list')) {
      return MyListLocation(routeInformation);
    }
    return NotFound(path: routeInformation.location!);
  },
);

final notificationTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/notification',
  locationBuilder: (routeInformation, _) {
    return NotFound(
      path: routeInformation.location!,
    );
  },
);

final accountTabHomeRouteDelegate = BeamerDelegate(
  initialPath: '/account',
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('/account')) {
      return AccountLocation(routeInformation);
    }
    return NotFound();
  },
);
