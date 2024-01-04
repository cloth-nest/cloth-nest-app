import 'dart:io';

import 'package:animations/animations.dart';
import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/factories/widgets/dialog/dialog_one_button.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/routes/home_location.dart';
import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:ecommerce/presentation/widgets/bottom_navigation_manager.dart';
import 'package:ecommerce/presentation/widgets/indexed_transition_switcher.dart';
import 'package:ecommerce/presentation/widgets/nav_item/btn_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_back_button_dispatcher.dart';

enum MainTab { top, search, myList, cart, order, account }

class MainGlobalKey {
  // ignore: library_private_types_in_public_api
  static GlobalKey<_MainScreenState> key = GlobalKey();
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String getItemPathByCurrentIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return '/top';
      case 1:
        return '/search';
      case 2:
        return '/my-list';
      case 3:
        return '/cart';
      case 4:
        return '/order';
      case 5:
        return '/account';
      default:
        return '/not-found';
    }
  }

  void _handleTapItemActive(int index, BuildContext context) {
    final firstBeamingHistory = Beamer.of(context).beamingHistory.first;
    final lastLocationHistory =
        firstBeamingHistory.history.last.routeInformation.location ?? '';
    if (index == MainTab.top.index &&
        BottomNavigationManager().isLocationTopNavigator(lastLocationHistory)) {
      final offset = BottomNavigationManager().getTopScrollController().offset;
      if (offset == 0) {
        return;
      }
      if (offset > 0) {
        BottomNavigationManager().getTopScrollController().animateTo(0,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
        return;
      }
    }
    if (index == MainTab.search.index &&
        BottomNavigationManager()
            .isLocationSearchNavigator(lastLocationHistory)) {
      final offset =
          BottomNavigationManager().getSearchScrollController().offset;
      if (offset == 0) {
        return;
      }
      if (offset > 0) {
        BottomNavigationManager().getSearchScrollController().animateTo(0,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
        return;
      }
    }

    if (index == MainTab.cart.index &&
        BottomNavigationManager()
            .isLocationTvScheduleNavigator(lastLocationHistory)) {
      final offset =
          BottomNavigationManager().getTvScheduleScrollController().offset;
      if (offset == 0) {
        return;
      }
      if (offset > 0) {
        BottomNavigationManager().getTvScheduleScrollController().animateTo(0,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
        return;
      }
    }

    if (index == MainTab.order.index &&
        BottomNavigationManager()
            .isLocationOrderNavigator(lastLocationHistory)) {
      final offset =
          BottomNavigationManager().getOrderScrollController().offset;
      if (offset == 0) {
        return;
      }
      if (offset > 0) {
        BottomNavigationManager().getOrderScrollController().animateTo(0,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
        return;
      }
    }

    if (index == MainTab.account.index &&
        BottomNavigationManager()
            .isLocationAccountNavigator(lastLocationHistory)) {
      final offset =
          BottomNavigationManager().getAccountScrollController().offset;
      if (offset == 0) {
        return;
      }
      if (offset > 0) {
        BottomNavigationManager().getAccountScrollController().animateTo(0,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
        return;
      }
    }

    homeRouteDelegate[index].popToNamed(getItemPathByCurrentIndex(index));
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = UserTokenSingleton().latestUserSession != null;

    return Scaffold(
      key: MainGlobalKey.key,
      body: Selector<MainPresenter, int>(
        selector: (_, notifier) => notifier.currentIndex,
        builder: (context, currentIndex, _) {
          return Selector<MainPresenter, int>(
            selector: (_, notifier) => notifier.beforeIndex,
            builder: (context, beforeIndex, _) {
              return IndexedTransitionSwitcher(
                reverse: Platform.isIOS ? beforeIndex > currentIndex : false,
                duration: const Duration(milliseconds: 350),
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) {
                  return Platform.isIOS
                      ? SharedAxisTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        )
                      : FadeThroughTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          child: child,
                        );
                },
                index: currentIndex,
                children: [
                  // use Beamer widgets as children
                  Beamer(
                    key: const ValueKey<int>(0),
                    routerDelegate: homeRouteDelegate[MainTab.top.index],
                    backButtonDispatcher: CustomBackButtonDispatcher(
                      alwaysBeamBack: false,
                      fallbackToBeamBack: false,
                      delegate: homeRouteDelegate[MainTab.top.index],
                      context: context,
                    ),
                  ),
                  Beamer(
                    key: const ValueKey<int>(1),
                    routerDelegate: homeRouteDelegate[MainTab.search.index],
                    backButtonDispatcher: CustomBackButtonDispatcher(
                      alwaysBeamBack: false,
                      fallbackToBeamBack: false,
                      delegate: homeRouteDelegate[MainTab.search.index],
                      context: context,
                    ),
                  ),
                  Beamer(
                    key: const ValueKey<int>(2),
                    routerDelegate: homeRouteDelegate[MainTab.myList.index],
                    backButtonDispatcher: CustomBackButtonDispatcher(
                      alwaysBeamBack: false,
                      fallbackToBeamBack: false,
                      delegate: homeRouteDelegate[MainTab.myList.index],
                      context: context,
                    ),
                  ),
                  Beamer(
                    key: const ValueKey<int>(3),
                    routerDelegate: homeRouteDelegate[MainTab.cart.index],
                    backButtonDispatcher: CustomBackButtonDispatcher(
                      alwaysBeamBack: false,
                      fallbackToBeamBack: false,
                      delegate: homeRouteDelegate[MainTab.cart.index],
                      context: context,
                    ),
                  ),
                  Beamer(
                    key: const ValueKey<int>(4),
                    routerDelegate: homeRouteDelegate[MainTab.order.index],
                    backButtonDispatcher: CustomBackButtonDispatcher(
                      alwaysBeamBack: false,
                      fallbackToBeamBack: false,
                      delegate: homeRouteDelegate[MainTab.order.index],
                      context: context,
                    ),
                  ),
                  Beamer(
                    key: const ValueKey<int>(5),
                    routerDelegate: homeRouteDelegate[MainTab.account.index],
                    backButtonDispatcher: CustomBackButtonDispatcher(
                      alwaysBeamBack: false,
                      fallbackToBeamBack: false,
                      delegate: homeRouteDelegate[MainTab.account.index],
                      context: context,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      // the usual BottomNavigationBar
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: Selector<MainPresenter, int>(
          selector: (_, notifier) => notifier.currentIndex,
          builder: (context, currentIndex, _) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: Platform.isIOS
                  ? EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).size.height < 700 ? 15 : 0)
                  : const EdgeInsets.only(top: 10, bottom: 15),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                currentIndex: currentIndex,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0x00ffffff),
                items: [
                  BottomNavigationBarItem(
                      label: 'Home',
                      icon: BtnNavItem(
                        btnName: LocaleKeys.navHomeButtonText.tr(),
                        isActive: false,
                        iconPath: SvgPaths.iconHome,
                      ),
                      activeIcon: BtnNavItem(
                        btnName: LocaleKeys.navHomeButtonText.tr(),
                        isActive: true,
                        iconPath: SvgPaths.iconHome,
                      )),
                  BottomNavigationBarItem(
                      label: 'Search',
                      icon: BtnNavItem(
                        btnName: LocaleKeys.navSearchButtonText.tr(),
                        isActive: false,
                        iconPath: SvgPaths.iconSearch,
                      ),
                      activeIcon: BtnNavItem(
                        btnName: LocaleKeys.navSearchButtonText.tr(),
                        isActive: true,
                        iconPath: SvgPaths.iconSearch,
                      )),
                  BottomNavigationBarItem(
                      label: 'My List',
                      icon: BtnNavItem(
                        btnName: LocaleKeys.navListButtonText.tr(),
                        isActive: false,
                        iconPath: SvgPaths.iconMyList,
                      ),
                      activeIcon: BtnNavItem(
                        btnName: LocaleKeys.navListButtonText.tr(),
                        isActive: true,
                        iconPath: SvgPaths.iconMyList,
                      )),
                  BottomNavigationBarItem(
                    label: 'Cart',
                    icon: BtnNavItem(
                      btnName: LocaleKeys.navCartButtonText.tr(),
                      isActive: false,
                      iconPath: SvgPaths.iconCartSvg,
                    ),
                    activeIcon: BtnNavItem(
                      btnName: LocaleKeys.navCartButtonText.tr(),
                      isActive: true,
                      iconPath: SvgPaths.iconCartSvg,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Order',
                    icon: BtnNavItem(
                      btnName: LocaleKeys.navOrderButtonText.tr(),
                      isActive: false,
                      iconPath: SvgPaths.iconOrder,
                    ),
                    activeIcon: BtnNavItem(
                      btnName: LocaleKeys.navOrderButtonText.tr(),
                      isActive: true,
                      iconPath: SvgPaths.iconOrder,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Account',
                    icon: BtnNavItem(
                      btnName: LocaleKeys.navProfileButtonText.tr(),
                      isActive: false,
                      iconPath: SvgPaths.iconProfile,
                    ),
                    activeIcon: BtnNavItem(
                      btnName: LocaleKeys.navProfileButtonText.tr(),
                      isActive: true,
                      iconPath: SvgPaths.iconProfile,
                    ),
                  ),
                ],
                onTap: (index) {
                  if ((index == MainTab.cart.index ||
                          index == MainTab.order.index) &&
                      !isAuthenticated) {
                    dialogOneButton(
                      context,
                      title: 'Log in',
                      content:
                          'When you log in to ClothNest!, you can create a list of your products and can buy later',
                      buttonOne: 'Login',
                      buttonOneTap: () {
                        Beamer.of(context, root: true).beamToReplacementNamed(
                          '/login',
                        );
                      },
                    );
                    return;
                  } else if (index == MainTab.cart.index) {
                    context.read<CartPresenter>().initData();
                  } else if (index == MainTab.myList.index) {
                    context.read<MyListPresenter>().getData();
                  }
                  if (index == currentIndex) {
                    _handleTapItemActive(index, context);
                  }
                  if (index != currentIndex) {
                    BottomNavigationManager().addHistoryByIndexBottom(index);
                    context.read<MainPresenter>().changeIndex(index);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
