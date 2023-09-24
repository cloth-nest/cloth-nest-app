import 'package:ecommerce/data/models/account/setting_account_model.dart';
import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingAccountModelAdapter());
  Hive.registerAdapter(TokenModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
}
