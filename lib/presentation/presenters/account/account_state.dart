// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';
import 'package:ecommerce/domain/entities/user/user_entity.dart';

enum Destination { setting, login, address }

class AccountState {
  final bool isLoading;
  final Destination? navigateTo;
  final UserEntity user;
  final String appVersion;
  final SettingAccountEntity settingAccount;

  factory AccountState.initial() {
    return AccountState(
      isLoading: false,
      user: UserEntity.inital(),
      appVersion: '',
      settingAccount: SettingAccountEntity.initial(),
    );
  }

  AccountState({
    required this.isLoading,
    this.navigateTo,
    required this.user,
    required this.appVersion,
    required this.settingAccount,
  });

  AccountState copyWith({
    bool? isLoading,
    Destination? navigateTo,
    UserEntity? user,
    String? appVersion,
    SettingAccountEntity? settingAccount,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      navigateTo: navigateTo,
      user: user ?? this.user,
      appVersion: appVersion ?? this.appVersion,
      settingAccount: settingAccount ?? this.settingAccount,
    );
  }
}
