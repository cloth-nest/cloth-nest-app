import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/home_location.dart';
import 'package:ecommerce/app/routes/login_location.dart';
import 'package:ecommerce/app/routes/onboarding/onboarding_location.dart';
import 'package:flutter/material.dart';

Future<BeamerDelegate> makeRootRouteDelegate() async {
  String initialPath = '';

  // check authenticated ? /login : /home

  initialPath = '/login';

  debugPrint('#initialPath $initialPath');

  return BeamerDelegate(
    initialPath: initialPath,
    routeListener: (routeInformation, delegate) {},
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        OnboardingLocation(),
        LoginLocation(),
        HomeLocation(),
        // home location
        // login location
        // onboarding location
      ],
    ),
  );
}
