import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/permission/open_app_settings_factory.dart';
import 'package:ecommerce/app/factories/widgets/dialog/dialog_one_button.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:ecommerce/presentation/presenters/account/account_state.dart';
import 'package:ecommerce/presentation/presenters/authentication/provider_authentication_presenter.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:ecommerce/presentation/screens/account/widgets/button_choose_language.dart';
import 'package:ecommerce/presentation/screens/account/widgets/button_loggin.dart';
import 'package:ecommerce/presentation/screens/account/widgets/button_logout.dart';
import 'package:ecommerce/presentation/screens/account/widgets/button_switch.dart';
import 'package:ecommerce/presentation/screens/account/widgets/item_account.dart';
import 'package:ecommerce/presentation/screens/account/widgets/item_account_list.dart';
import 'package:ecommerce/presentation/screens/authentication/authentication_presenter.dart';
import 'package:ecommerce/presentation/widgets/bottom_navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<AccountPresenter>();
    final isAuthenticated =
        context.read<AuthenticationPresenter>().authenticatedState ==
            AuthenticatedState.authorized;
    if (isAuthenticated) {
      _presenter.fetchProfile();
    }
    _presenter.getAppVersion();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      switch (_presenter.navigateTo) {
        case Destination.login:
          Beamer.of(context, root: true).beamToReplacementNamed('/login');
          break;
        case Destination.address:
          _beamTo('address');
          break;
        case Destination.profile:
          _beamTo('profile');
          break;
        default:
          openAppSettings();
          break;
      }
    }
  }

  void _beamTo(String path) {
    final String currentLocation =
        context.currentBeamLocation.state.routeInformation.location ?? '/';
    final uri = Uri.parse(currentLocation);
    context.beamToNamed('${uri.path}/$path');
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated =
        context.read<AuthenticationPresenter>().authenticatedState ==
            AuthenticatedState.authorized;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Account',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          controller: BottomNavigationManager().getAccountScrollController(),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const SizedBox(height: 10),
            //avatar + name + gmail
            isAuthenticated
                ? _buildAccountInfo()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ButtonLogin(
                      onTap: () {},
                    ),
                  ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 12,
                      height: 18 / 12,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            ItemAccountList(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: ItemAccount(
                    content: 'Notification',
                    hasNotificationDot: true,
                    trailing: SvgPicture.asset(SvgPaths.iconArrowRight),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _presenter.navigateToProfileScreen();
                  },
                  child: ItemAccount(
                    content: 'Edit Profile',
                    trailing: SvgPicture.asset(SvgPaths.iconArrowRight),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _presenter.navigateToAddressScreen();
                  },
                  child: ItemAccount(
                    content: 'Saved Address',
                    trailing: SvgPicture.asset(SvgPaths.iconArrowRight),
                  ),
                ),
                ItemAccount(
                  content: 'Version',
                  hasBorder: false,
                  trailing: Selector<AccountPresenter, String>(
                    builder: (context, version, _) {
                      return Text(
                        version,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 14,
                              height: 16.71 / 14,
                            ),
                      );
                    },
                    selector: (_, presenter) => presenter.appVersion,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Setting',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 12,
                      height: 18 / 12,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            ItemAccountList(
              children: [
                Selector<AccountPresenter, bool>(
                  builder: (context, isSendNotification, _) => ItemAccount(
                    content: 'Receive Notification',
                    paddingRight: 13.5,
                    trailing: ButtonSwitch(
                      value: isSendNotification,
                      onChanged: (_) => _presenter.openNotificationSetting(),
                    ),
                  ),
                  selector: (_, presenter) =>
                      presenter.settingAccount.isAllowSendNotification,
                ),
                Selector<AccountPresenter, bool>(
                  builder: (context, isDarkMode, _) => ItemAccount(
                    content: 'Dark Theme',
                    paddingRight: 13.5,
                    trailing: ButtonSwitch(
                      value: isDarkMode,
                      onChanged: (_) => () {},
                    ),
                  ),
                  selector: (_, presenter) =>
                      presenter.settingAccount.isDarkMode,
                ),
                const ItemAccount(
                  content: 'Language',
                  trailing: ButtonChooseLanguage(),
                  hasBorder: false,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            if (isAuthenticated)
              ButtonLogout(
                onTap: _showLogoutDialog,
              ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() async {
    await dialogOneButton(
      context,
      title: 'Confirmation',
      content: 'Are you sure that you want to logout?',
      buttonOne: 'Log out',
      buttonOneTap: () => _presenter.logout(),
    );
  }

  Widget _buildAccountInfo() {
    return Selector<AccountPresenter, UserEntity>(
      builder: (context, user, _) {
        return Row(
          children: [
            _presenter.user.avatar.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(_presenter.user.avatar),
                    radius: 25,
                  )
                : Image.asset(
                    'assets/images/default_avatar.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                '${_presenter.user.firstName} ${_presenter.user.lastName}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 18,
                      height: 27 / 18,
                    ),
              ),
            ),
          ],
        );
      },
      selector: (_, presenter) => presenter.user,
    );
  }
}
