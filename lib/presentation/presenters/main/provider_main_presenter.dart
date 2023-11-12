import 'package:ecommerce/presentation/screens/main/main_presenter.dart';
import 'package:ecommerce/presentation/widgets/bottom_navigation_manager.dart';
import 'package:flutter/material.dart';

class ProviderMainPresenter extends ChangeNotifier implements MainPresenter {
  int _beforeIndex;
  int _currentIndex;
  bool _mounted = true;

  ProviderMainPresenter({
    int beforeIndex = 0,
    int currentIndex = 0,
  })  : _beforeIndex = beforeIndex,
        _currentIndex = currentIndex {
    BottomNavigationManager().addHistoryByIndexBottom(currentIndex);
  }
  @override
  int get beforeIndex => _beforeIndex;

  @override
  void changeIndex(int newIndex) {
    _beforeIndex = _currentIndex;
    _currentIndex = newIndex;

    /// consider to use it
    /// when use it, change language is wrong
    //homeRouteDelegate[newIndex].update(rebuild: false);
    if (_mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  @override
  int get currentIndex => _currentIndex;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
