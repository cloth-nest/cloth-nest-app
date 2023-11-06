import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';
import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:ecommerce/presentation/presenters/account/account_state.dart';
import 'package:flutter/material.dart';

abstract class AccountPresenter implements ChangeNotifier {
  void logout();
  void testAutoLogin();
  void fetchProfile();
  void getAppVersion();
  void openNotificationSetting();
  void navigateToAddressScreen();

  UserEntity get user;
  SettingAccountEntity get settingAccount;
  bool get isLoading;
  Destination? get navigateTo;
  String get appVersion;
}
