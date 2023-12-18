import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/routes/home_location.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_screen.dart';
import 'package:ecommerce/presentation/widgets/bottom_navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomBackButtonDispatcher extends RootBackButtonDispatcher {
  static const int animationDuration = 750;

  CustomBackButtonDispatcher({
    required this.delegate,
    this.onBack,
    this.alwaysBeamBack = false,
    this.fallbackToBeamBack = true,
    required this.context,
  });

  final BuildContext context;

  final BeamerDelegate delegate;

  final Future<bool> Function(BeamerDelegate delegate)? onBack;

  final bool alwaysBeamBack;

  final bool fallbackToBeamBack;

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) async {
    if (onBack != null) {
      return (await onBack!(delegate));
    }

    if (alwaysBeamBack) {
      return delegate.beamBack();
    }

    final didPopRoute = await super.invokeCallback(defaultValue);
    if (didPopRoute) {
      return didPopRoute;
    }

    if (fallbackToBeamBack) {
      return delegate.beamBack();
    } else {
      return false;
    }
  }

  @override
  Future<bool> didPopRoute() async {
    if (isBottomNavigatorLocation()) {
      if (await handleDoubleHistoryLocation()) {
        return true;
      }
      if (await handleSingleHistoryLocation()) {
        return true;
      }
      if (handleBottomNavigatorLocation()) {
        return true;
      }
    }
    if (isNestedTopBottomNavigation()) {
      if (topTabHomeRouteDelegate.canPopBeamLocation) {
        return topTabHomeRouteDelegate.popBeamLocation();
      }
    }
    if (isNestedSearchBottomNavigation()) {
      final lastSearchContext =
          BottomNavigationManager().getLastSearchContext();
      return lastSearchContext.beamBack();
    }
    return context.beamBack();
  }

  bool isNestedTopBottomNavigation() {
    if (context.beamingHistory.isNotEmpty) {
      final firstBeamingHistory = context.beamingHistory.first;
      final lastLocationHistory =
          firstBeamingHistory.history.last.routeInformation.location ?? '';
      final pattern = RegExp(r'/top/.+');
      final hasMatch = pattern.hasMatch(lastLocationHistory);
      return hasMatch;
    }
    return false;
  }

  bool isNestedSearchBottomNavigation() {
    if (context.beamingHistory.isNotEmpty) {
      final firstBeamingHistory = context.beamingHistory.first;
      final lastLocationHistory =
          firstBeamingHistory.history.last.routeInformation.location ?? '';
      final pattern = RegExp(r'/search/.+');
      final hasMatch = pattern.hasMatch(lastLocationHistory);
      return hasMatch;
    }
    return false;
  }

  bool isBottomNavigatorLocation() {
    if (context.beamingHistory.isNotEmpty) {
      final firstBeamingHistory = context.beamingHistory.first;
      final lastLocationHistory =
          firstBeamingHistory.history.last.routeInformation.location ?? '';
      if (BottomNavigationManager()
          .isLocationBottomNavigator(lastLocationHistory)) {
        return true;
      }
    }
    return false;
  }

  bool isSingleHistoryLocation() {
    final navigationHistoryCount =
        BottomNavigationManager().getHistories().length;
    return navigationHistoryCount == 1;
  }

  bool isDoubleHistoryLocation() {
    final navigationHistoryCount =
        BottomNavigationManager().getHistories().length;
    return navigationHistoryCount == 2;
  }

  Future<bool> popAppToBackground() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isAndroid) {
        exit(0);
      } else {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
    return true;
  }

  Future<bool> handleSingleHistoryLocation() async {
    // get last item in history from NavigationManager histories
    final lastHistory = BottomNavigationManager().getLastHistory();

    if (lastHistory == '/initial' && isSingleHistoryLocation()) {
      return popAppToBackground();
    }
    return false;
  }

  Future<bool> handleDoubleHistoryLocation() async {
    try {
      // get last item in history from NavigationManager histories
      final firstBeamingHistory = context.beamingHistory.first;
      final lastLocationHistory =
          firstBeamingHistory.history.last.routeInformation.location;
      if (isDoubleHistoryLocation() && lastLocationHistory == '/top') {
        // remove last item in history from NavigationManager histories
        BottomNavigationManager().removeLastHistory();

        return popAppToBackground();
      }
      if (isDoubleHistoryLocation()) {
        // remove last item in history from NavigationManager histories
        BottomNavigationManager().removeLastHistory();

        // go to top screen because only 1 item in history
        context.read<MainPresenter>().changeIndex(MainTab.top.index);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  bool changeIndexAndReturnTrue(int index) {
    context.read<MainPresenter>().changeIndex(index);
    return true;
  }

  int getIndexForLastHistory(String lastHistory) {
    int index = -1;
    if (lastHistory == '/top') {
      index = MainTab.top.index;
    } else if (lastHistory == '/search') {
      index = MainTab.search.index;
    } else if (lastHistory == '/my-list') {
      index = MainTab.myList.index;
    } else if (lastHistory == '/cart') {
      index = MainTab.cart.index;
    } else if (lastHistory == '/e') {
      index = MainTab.account.index;
    }
    return index;
  }

  bool handleBottomNavigatorLocation() {
    // remove last item in history from NavigationManager histories
    BottomNavigationManager().removeLastHistory();
    // get last item in history from NavigationManager histories
    final newLastHistory = BottomNavigationManager().getLastHistory();
    int index = getIndexForLastHistory(newLastHistory);
    if (index != -1) {
      return changeIndexAndReturnTrue(index);
    }
    return false;
  }
}
