import 'package:ecommerce/presentation/presenters/product_detail/product_detail_state.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';

class ProviderProductDetailPresenter
    with ChangeNotifier
    implements ProductDetailPresenter {
  ProductDetailState _state;

  ProviderProductDetailPresenter({required ProductDetailState state})
      : _state = state;

  @override
  int get activePage => _state.activePage;

  @override
  void setActivePage(int page) {
    _state = _state.copyWith(activePage: page);
    notifyListeners();
  }

  @override
  PageController get pageController => _state.pageController;

  @override
  void setTabIndex(int newIndex) {
    if (newIndex != tabIndex) {
      _state = _state.copyWith(tabIndex: newIndex);
      notifyListeners();
    }
  }

  @override
  int get tabIndex => _state.tabIndex;
}
