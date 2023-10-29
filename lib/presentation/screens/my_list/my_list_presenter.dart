import 'package:flutter/foundation.dart';

abstract class MyListPresenter implements ChangeNotifier {
  Future<void> refreshData();
  void getData();

  bool get isLoading;
}
