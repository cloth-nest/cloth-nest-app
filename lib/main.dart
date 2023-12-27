import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app.dart';
import 'package:ecommerce/app/factories/cache/hive.dart';
import 'package:ecommerce/app/factories/presentation/main/main_presenter_factory.dart';
import 'package:ecommerce/app/routes/route.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/infra/firebase/firebase_singleton_remote_message_adapter.dart';
import 'package:ecommerce/infra/local_notification/flutter_local_notification_adapter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

  final token = await FirebaseSingletonRemoteMessageAdapter().getToken();

  debugPrint('##token: $token');
  runApp(
    MultiProvider(
      providers: makeMainPresenters(),
      child: EcommerceView(
        rootRouteDelegate: rootRouteDelegate,
      ),
    ),
  );
}
