import 'package:ecommerce/presentation/presenters/top/top_state.dart';
import 'package:ecommerce/presentation/screens/top/top_presenter.dart';
import 'package:flutter/material.dart';

class ProviderTopPresenter with ChangeNotifier implements TopPresenter {
  TopState _state;

  ProviderTopPresenter({
    required TopState state,
  }) : _state = state;

  @override
  bool get isShowButton => _state.isShowButton;

  @override
  TextEditingController get searchController => _state.searchController;

  @override
  void onClearText() {
    _state.searchController.clear();
    _state = _state.copyWith(isShowButton: false);
    notifyListeners();
  }

  @override
  void onKeywordChanged(String keyword) {
    if (keyword.isNotEmpty && !_state.isShowButton) {
      _state = _state.copyWith(isShowButton: true);
      notifyListeners();
    } else if (keyword.isEmpty && _state.isShowButton) {
      _state = _state.copyWith(isShowButton: false);
      notifyListeners();
    }
  }

  @override
  void onSubmitted(String keyword) {}

  @override
  void changeTab(int newIndex) {
    if (_state.currentTabIndex != newIndex) {
      _state = _state.copyWith(currentTabIndex: newIndex);
      notifyListeners();
    }
  }

  @override
  int get tabIndex => _state.currentTabIndex;

  @override
  void saveKeyword(String keyword) {
    // try {
    //   final historySearch = _state.historySearch.keywords;
    //   final reversedHistorySearch = historySearch.reversed.toSet().toList();
    //   final saveListHistorySearch = HistorySearchEntity(
    //     keywords: [
    //       ...reversedHistorySearch,
    //       keyword.trim(),
    //     ].reversed.toSet().toList(),
    //   );
    //   _state = _state.copyWith(
    //     historySearch: HistorySearchEntity(
    //       keywords: saveListHistorySearch.keywords.take(10).toList(),
    //     ),
    //   );
    //   notifyListeners();
    //   _saveHistorySearch.call(saveListHistorySearch);
    // } catch (e) {
    //   debugPrint('error save history search: $e');
    // }
  }

  // @override
  // HistorySearchEntity get historySearch => _state.historySearch;

  @override
  bool validateKeyWord(String keyword) {
    return keyword.isEmpty ? false : true;
  }

  @override
  void refreshState() {
    _state = TopState.initial();
  }

  @override
  void fetchHistorySearch() {
    // TODO: implement fetchHistorySearch
  }
}
