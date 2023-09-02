import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app.dart';
import 'package:ecommerce/app/factories/cache/hive.dart';
import 'package:ecommerce/app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Init Locale
  await EasyLocalization.ensureInitialized();

  // Init Hive
  await initHive();

  final rootRouteDelegate = await makeRootRouteDelegate();

  runApp(
    MultiProvider(
      providers: [],
      child: EcommerceView(
        rootRouteDelegate: rootRouteDelegate,
      ),
    ),
  );
}
