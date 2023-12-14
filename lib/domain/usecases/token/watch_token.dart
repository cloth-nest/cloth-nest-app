import 'package:hive_flutter/hive_flutter.dart';

abstract class ListenerUserToken {
  Future<Stream<BoxEvent>> call(String key);
}
