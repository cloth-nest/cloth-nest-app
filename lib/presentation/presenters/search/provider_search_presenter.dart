import 'package:ecommerce/presentation/presenters/search/search_state.dart';
import 'package:ecommerce/presentation/screens/search/search_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSearchPresenter with ChangeNotifier implements SearchPresenter {
  SearchState _state;

  ProviderSearchPresenter({
    required SearchState state,
  }) : _state = state;

  @override
  void changeTab(int newIndex) {
    if (_state.currentTabIndex != newIndex) {
      _state = _state.copyWith(currentTabIndex: newIndex);
      notifyListeners();
    }
  }

  @override
  int get tabIndex => _state.currentTabIndex;
}
