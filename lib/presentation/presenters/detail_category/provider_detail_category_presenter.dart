import 'package:ecommerce/presentation/presenters/detail_category/detail_category_state.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:flutter/material.dart';

class ProviderDetailCategoryPresenter
    with ChangeNotifier
    implements DetailCategoryPresenter {
  DetailCategoryState _state;

  ProviderDetailCategoryPresenter({required DetailCategoryState state})
      : _state = state;

  @override
  void changeTab(int newIndex) async {
    if (tabIndex != newIndex) {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      await fetchData();

      _state = _state.copyWith(
        tabIndex: newIndex,
        isLoading: false,
        selectedColors: [],
        selectedPrices: [],
        selectedSizes: [],
        sort: 'Created descending',
      );
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  List<String> get colors => _state.colors;

  @override
  bool get isLoading => _state.isLoading;

  @override
  List<String> get prices => _state.prices;

  @override
  List<Map<String, dynamic>> get selectedColors => _state.selectedColors;

  @override
  List<Map<String, dynamic>> get selectedPrices => _state.selectedPrices;

  @override
  List<Map<String, dynamic>> get selectedSizes => _state.selectedSizes;

  @override
  List<String> get sizes => _state.sizes;

  @override
  int get tabIndex => _state.tabIndex;

  @override
  Future pullToRefresh() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await fetchData();

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  @override
  bool get hasFilter {
    if (selectedColors.isNotEmpty ||
        selectedPrices.isNotEmpty ||
        selectedSizes.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void setSelectedColors(List<Map<String, dynamic>> value) async {
    if (value != selectedColors) {
      bool isEmpty = true;

      for (final data in value) {
        if (data['value'] == true) {
          isEmpty = false;
          break;
        }
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedColors: isEmpty ? [] : value,
      );

      notifyListeners();

      await fetchData();

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  @override
  void setSelectedPrices(List<Map<String, dynamic>> value) async {
    if (value != selectedPrices) {
      bool isEmpty = true;

      for (final data in value) {
        if (data['value'] == true) {
          isEmpty = false;
          break;
        }
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedPrices: isEmpty ? [] : value,
      );

      notifyListeners();

      await fetchData();

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  @override
  void setSelectedSizes(List<Map<String, dynamic>> value) async {
    if (value != selectedSizes) {
      bool isEmpty = true;

      for (final data in value) {
        if (data['value'] == true) {
          isEmpty = false;
          break;
        }
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedSizes: isEmpty ? [] : value,
      );

      notifyListeners();

      await fetchData();

      _state = _state.copyWith(
        isLoading: false,
      );

      notifyListeners();
    }
  }

  @override
  void setSort(String value) async {
    if (sort != value) {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      await fetchData();

      _state = _state.copyWith(isLoading: false, sort: value);
      notifyListeners();
    }
  }

  @override
  String get sort => _state.sort;
}
