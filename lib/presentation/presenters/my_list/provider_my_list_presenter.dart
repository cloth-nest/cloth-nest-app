import 'package:ecommerce/presentation/presenters/my_list/my_list_state.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:flutter/material.dart';

class ProviderMyListPresenter with ChangeNotifier implements MyListPresenter {
  MyListState _state;

  ProviderMyListPresenter({
    required MyListState state,
  }) : _state = state;

  @override
  bool get isLoading => _state.isLoading;

  @override
  Future getData() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(seconds: 5));

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  @override
  Future<void> refreshData() async {
    await getData();
  }
}
