import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/configs/i18n/app_languages.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class EcommerceView extends StatefulWidget {
  final BeamerDelegate rootRouteDelegate;

  const EcommerceView({
    super.key,
    required this.rootRouteDelegate,
  });

  @override
  State<EcommerceView> createState() => _EcommerceViewState();
}

class _EcommerceViewState extends State<EcommerceView> {
  @override
  Widget build(BuildContext context) {
    return EcommerceApp(
      rootRouteDelegate: widget.rootRouteDelegate,
    );
  }
}

class EcommerceApp extends StatefulWidget {
  final BeamerDelegate rootRouteDelegate;

  const EcommerceApp({
    super.key,
    required this.rootRouteDelegate,
  });

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppLanguages.supportedLocales,
      fallbackLocale: AppLanguages.fallbackLocale,
      startLocale: AppLanguages.fallbackLocale,
      path: 'assets/translations',
      child: Builder(
        builder: (context) {
          debugPrint('locale: ${context.locale}');
          return MaterialApp.router(
            scrollBehavior: const MyScrollBehavior(),
            key: NavigationService.navigatorKey,
            title: 'Clothnest',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.lightTheme,
            themeMode: ThemeMode.system,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            routerDelegate: widget.rootRouteDelegate,
            routeInformationParser: BeamerParser(),
            backButtonDispatcher: BeamerBackButtonDispatcher(
              delegate: widget.rootRouteDelegate,
              alwaysBeamBack: false,
              fallbackToBeamBack: false,
            ),
          );
        },
      ),
    );
  }
}

class MyScrollBehavior extends ScrollBehavior {
  const MyScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
