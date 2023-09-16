import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';

abstract class SaveSettingAccount {
  Future<void> call({required SettingAccountEntity settingAccount});
}
