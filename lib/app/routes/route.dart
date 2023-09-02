import 'package:beamer/beamer.dart';

Future<BeamerDelegate> makeRootRouteDelegate() async {
  String initialPath = '';

  // check authenticated ? /login : /home

  initialPath = '/home';

  return BeamerDelegate(
    initialPath: initialPath,
    routeListener: (routeInformation, delegate) {},
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        // home location
        // login location
        // onboarding location
      ],
    ),
  );
}
