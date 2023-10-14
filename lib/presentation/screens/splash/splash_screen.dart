import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/splash/splash_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../app/resources/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashPresenter splashPresenter;
  late final ContentMasterPresenter contentMasterPresenter;

  @override
  void initState() {
    super.initState();

    splashPresenter = context.read<SplashPresenter>();
    contentMasterPresenter = context.read<ContentMasterPresenter>();

    splashPresenter.addListener(_onListener);
    Future.delayed(const Duration(milliseconds: 1000), () async {
      //await loadApi();
      await contentMasterPresenter.fetchMasterCategory();

      splashPresenter.findNextRoute();
    });
  }

  void _onListener() {
    String nextRoute = splashPresenter.navigateTo;

    if (nextRoute.isNotEmpty) {
      context.beamToReplacementNamed(nextRoute);
    }
  }

  @override
  void dispose() {
    super.dispose();
    splashPresenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: SvgPicture.asset(
        SvgPaths.iconLogo,
        width: 100,
        height: 100,
      ),
      splashIconSize: 500,
      nextScreen: Container(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      disableNavigation: true,
    );
  }
}
