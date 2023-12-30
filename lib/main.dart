import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app.dart';
import 'package:ecommerce/app/factories/cache/hive.dart';
import 'package:ecommerce/app/factories/presentation/accessibility/accessibility_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/content_master/content_master_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/main/main_presenter_factory.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/app/protocols/firebase.dart';
import 'package:ecommerce/app/routes/home_location.dart';
import 'package:ecommerce/app/routes/route.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/infra/firebase/firebase_singleton_remote_message_adapter.dart';
import 'package:ecommerce/infra/local_notification/flutter_local_notification_adapter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('handleBackgroundMessage');
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'ClothNest-user',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Init Locale
  await EasyLocalization.ensureInitialized();

  // Init Hive
  await initHive();

  final rootRouteDelegate = await makeRootRouteDelegate();

  FirebaseSingletonRemoteMessageAdapter().initPushNotification();
  FlutterSingletonLocalNotificationAdapter().initialize();
  FlutterSingletonLocalNotificationAdapter()
      .setRootRouteDelegate(rootRouteDelegate);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final accessibilityPresenter = makeAccessibilityPresenter();

  FirebaseSingletonRemoteMessageAdapter()
      .subscribeObserver(accessibilityPresenter as FirebaseMessageObserver);
  FlutterSingletonLocalNotificationAdapter().subscribe(
    accessibilityPresenter as LocalNotificationObserver,
  );

  final message =
      await FirebaseSingletonRemoteMessageAdapter().getInitialMessage();

  final contentMasterPresenter = makeContentMasterPresenter();
  final mainPresenter = makeMainPresenter();

  if (message != null) {
    debugPrint('#message: ${message.senderId}');

    final String screen = message.data['screen'] as String;
    if (screen.startsWith('/order')) {
      /// Fetch data with required await option
      await Future.wait([
        contentMasterPresenter.fetchCategories(),
      ]);
    }

    onClickNotification(
      message: message,
      delegate: rootRouteDelegate,
      mainPresenter: mainPresenter,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ...makeMainPresenters(accessibilityPresenter),
      ],
      child: EcommerceView(
        rootRouteDelegate: rootRouteDelegate,
      ),
    ),
  );
}

void onClickNotification({
  required RemoteMessage message,
  required BeamerDelegate delegate,
  required MainPresenter mainPresenter,
}) async {
  final data = message.data;
  String screen = data['screen'] as String;
  delegate.beamingHistory.clear();

  Future<void> navigateToScreen(
    String location,
    MainTab? tab,
    Function? callback,
  ) async {
    if (delegate.navigatorKey.currentContext != null) {
      // kill app current context will be null
      Navigator.of(delegate.navigatorKey.currentContext!, rootNavigator: true)
          .popUntil((route) => route.isFirst);
    }

    delegate
        .setInitialRoutePath(RouteInformation(location: location))
        .then((_) {
      if (tab != null) {
        mainPresenter.changeIndex(tab.index);
      }
      if (callback != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => callback());
      }
    });
  }

  if (screen.contains('/order')) {
    final userToken = await makeFetchLocalToken().call(key: uniqueUserTokenKey);

    if (userToken == null) {
      navigateToScreen('/login', null, null);
    } else {
      final List<String> params = screen.split('/')
        ..removeWhere((element) => element.isEmpty);
      final int idOrder = int.tryParse(params[2]) ?? -1;

      navigateToScreen('/order', MainTab.order, () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            orderTabHomeRouteDelegate
                .beamToNamed('/order/detail?idOrder=$idOrder');
          },
        );
      });
    }
  }
}

void onClickLocalNotification({
  required NotificationResponse message,
  required BeamerDelegate delegate,
  required MainPresenter mainPresenter,
}) async {
  delegate.beamingHistory.clear();

  Future<void> navigateToScreen(
    String location,
    MainTab? tab,
    Function? callback,
  ) async {
    if (delegate.navigatorKey.currentContext != null) {
      // kill app current context will be null
      Navigator.of(delegate.navigatorKey.currentContext!, rootNavigator: true)
          .popUntil((route) => route.isFirst);
    }

    delegate
        .setInitialRoutePath(RouteInformation(location: location))
        .then((_) {
      if (tab != null) {
        mainPresenter.changeIndex(tab.index);
      }
      if (callback != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => callback());
      }
    });
  }

  final userToken = await makeFetchLocalToken().call(key: uniqueUserTokenKey);

  if (userToken == null) {
    navigateToScreen('/login', null, null);
  } else {
    final List<String> params = message.payload!.split('/')
      ..removeWhere((element) => element.isEmpty);
    final int idOrder = int.tryParse(params[2]) ?? -1;

    navigateToScreen('/order', MainTab.order, () {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          orderTabHomeRouteDelegate
              .beamToNamed('/order/detail?idOrder=$idOrder');
        },
      );
    });
  }
}
