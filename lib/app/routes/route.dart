import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/app/routes/forget_password_location.dart';
import 'package:ecommerce/app/routes/home_location.dart';
import 'package:ecommerce/app/routes/login_location.dart';
import 'package:ecommerce/app/routes/onboarding/onboarding_location.dart';
import 'package:ecommerce/app/routes/reset_password_location.dart';
import 'package:ecommerce/app/routes/sign_up_location.dart';
import 'package:ecommerce/app/routes/splash_location.dart';
import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';

Future<BeamerDelegate> makeRootRouteDelegate() async {
  String initialPath = '/splash';

  final userToken = await makeFetchLocalToken().call(key: uniqueUserTokenKey);
  UserTokenSingleton().updateLatestUserToken(userToken);

  // Creating a listener for the user session
  final listenerUserToken = makeListenLocalUserToken();
  // Creating a stream for the user session using the unique user session key
  final streamUserSession = await listenerUserToken.call(uniqueUserTokenKey);
  // Listening to the stream and updating the latest user session in the singleton when a new session is received
  streamUserSession.listen((newSession) {
    UserTokenSingleton().updateLatestUserToken(newSession.value);
  });

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
        ResetPasswordLocation(),
        HomeLocation(),
      ],
    ),
  );
}
