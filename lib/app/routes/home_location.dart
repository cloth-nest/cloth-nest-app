import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/account/account_location.dart';
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
  locationBuilder: (routeInformation, _) {
    if (routeInformation.location!.contains('/home')) {
      return NotFound(path: routeInformation.location!);
    }
    return NotFound(path: routeInformation.location!);
  },
);

final searchTabHomeRouteDelegate = BeamerDelegate(
  locationBuilder: (routeInformation, _) {
    return NotFound(
      path: routeInformation.location!,
    );
  },
);

final myListTabHomeRouteDelegate = BeamerDelegate(
  locationBuilder: (routeInformation, _) {
    return NotFound(
      path: routeInformation.location!,
    );
  },
);

final notificationTabHomeRouteDelegate = BeamerDelegate(
  locationBuilder: (routeInformation, _) {
    return NotFound(
      path: routeInformation.location!,
    );
  },
);

final accountTabHomeRouteDelegate = BeamerDelegate(
  locationBuilder: (routeInformation, _) {
    return AccountLocation();
  },
);
