import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/configs/i18n/app_languages.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/presentation/presenters/accessibility/accessibility_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class _EcommerceViewState extends State<EcommerceView>
    with WidgetsBindingObserver {
  late AccessibilityPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = context.read<AccessibilityPresenter>();

    _presenter.addListener(_onListener);
    WidgetsBinding.instance.addObserver(this);
  }

  void _onListener() {
    final remoteMessage = _presenter.remoteMessage;
    final localMessage = _presenter.localMessage;

    if (remoteMessage != null) {
      onClickNotification(
        message: remoteMessage,
        mainPresenter: context.read<MainPresenter>(),
        delegate: widget.rootRouteDelegate,
      );
      _presenter.resetRemoteMessage();
      return;
    }
    if (localMessage != null) {
      onClickLocalNotification(
        message: localMessage,
        mainPresenter: context.read<MainPresenter>(),
        delegate: widget.rootRouteDelegate,
      );
      _presenter.resetLocalMessage();
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
  }

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
