import 'package:ecommerce/app/factories/usecases/profile/profile_factory.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/fetch_logout.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/logout_params.dart';
import 'package:ecommerce/domain/usecases/profile/fetch_profile.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:ecommerce/presentation/presenters/account/account_state.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProviderAccountPresenter with ChangeNotifier implements AccountPresenter {
  AccountState _state;

  final FetchToken _fetchToken;
  final FetchLogout _fetchRemoteLogout;
  final FetchLogout _fetchLocalLogout;
  final FetchProfile _fetchProfile;

  ProviderAccountPresenter({
    required AccountState state,
    required FetchToken fetchToken,
    required FetchLogout fetchRemoteLogout,
    required FetchLogout fetchLocalLogout,
    required FetchProfile fetchProfile,
  })  : _state = state,
        _fetchToken = fetchToken,
        _fetchRemoteLogout = fetchRemoteLogout,
        _fetchLocalLogout = fetchLocalLogout,
        _fetchProfile = fetchProfile;

  @override
  bool get isLoading => _state.isLoading;

  @override
  void logout() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    try {
      final TokenEntity? token =
          await _fetchToken.call(key: uniqueUserTokenKey);

      await _fetchRemoteLogout.call(
        params: LogoutParams(
          refreshToken: token?.refreshToken ?? '',
        ),
      );

      await _fetchLocalLogout.call();

      _state = _state.copyWith(
        isLoading: false,
        navigateTo: Destination.login,
      );
      notifyListeners();
    } catch (_) {
      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  @override
  Destination? get navigateTo => _state.navigateTo;

  @override
  void testAutoLogin() async {
    try {
      final fetchProfile = makeFetchProfile();
      await fetchProfile.call();
    } catch (_) {}
  }

  @override
  UserEntity get user => _state.user;

  @override
  void fetchProfile() async {
    try {
      UserEntity userEntity = await _fetchProfile.call();
      _state = _state.copyWith(user: userEntity);
      notifyListeners();
    } catch (e) {
      debugPrint('error fetch profile: $e');
    }
  }

  @override
  String get appVersion => _state.appVersion;

  @override
  void getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;

      _state = _state.copyWith(appVersion: version);

      notifyListeners();
    } catch (e) {
      debugPrint('error get app version: $e');
    }
  }

  @override
  void openNotificationSetting() {
    _state = _state.copyWith(
      navigateTo: Destination.setting,
    );

    notifyListeners();
  }

  @override
  SettingAccountEntity get settingAccount => _state.settingAccount;

  @override
  void navigateToAddressScreen() {
    _state = _state.copyWith(navigateTo: Destination.address);
    notifyListeners();
  }

  @override
  void navigateToProfileScreen() {
    _state = _state.copyWith(navigateTo: Destination.profile);
    notifyListeners();
  }

  @override
  void setNewUser(UserEntity? userEntity) {
    _state = _state.copyWith(user: userEntity);
    notifyListeners();
  }
}
