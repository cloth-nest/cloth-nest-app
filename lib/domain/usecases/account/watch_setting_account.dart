import 'package:hive/hive.dart';

abstract class WatchSettingAccount {
  Future<Stream<BoxEvent>> call({required String key});
}
