import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';

abstract class FetchSettingAccount {
  Future<SettingAccountEntity?> findOne({required String key});
}
