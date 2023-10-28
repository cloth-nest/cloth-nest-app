import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/forget_password_location.dart';
import 'package:ecommerce/app/routes/home_location.dart';
import 'package:ecommerce/app/routes/login_location.dart';
import 'package:ecommerce/app/routes/onboarding/onboarding_location.dart';
import 'package:ecommerce/app/routes/sign_up_location.dart';
import 'package:ecommerce/app/routes/splash_location.dart';

Future<BeamerDelegate> makeRootRouteDelegate() async {
  String initialPath = '/splash';

  return BeamerDelegate(
    initialPath: initialPath,
    routeListener: (routeInformation, delegate) {},
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        SplashLocation(),
        OnboardingLocation(),
        LoginLocation(),
        SignUpLocation(),
        ForgetPasswordLocation(),
        HomeLocation(),
      ],
    ),
  );
}
