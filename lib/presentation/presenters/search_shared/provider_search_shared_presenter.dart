import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:ecommerce/domain/usecases/history_search/fetch_history_search.dart';
import 'package:ecommerce/domain/usecases/history_search/save_history_search.dart';
import 'package:ecommerce/presentation/presenters/search_shared/search_shared_state.dart';
import 'package:ecommerce/presentation/screens/search_shared/search_shared_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSearchSharedPresenter
    with ChangeNotifier
    implements SearchSharedPresenter {
  SearchSharedState _state;
  final SaveHistorySearch _saveHistorySearch;
  final FetchHistorySearch _fetchHistorySearch;

  ProviderSearchSharedPresenter({
    required SearchSharedState state,
    required SaveHistorySearch saveHistorySearch,
    required FetchHistorySearch fetchHistorySearch,
  })  : _state = state,
        _saveHistorySearch = saveHistorySearch,
        _fetchHistorySearch = fetchHistorySearch;

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
  void fetchHistorySearch() async {
    try {
      final historySearch = await _fetchHistorySearch.call();
      _state = _state.copyWith(historySearch: historySearch);
      notifyListeners();
    } catch (e) {
      debugPrint('error fetch history search: $e');
    }
  }

  @override
  void saveKeyword(String keyword) {
    try {
      final historySearch = _state.historySearch.keywords;
      final reversedHistorySearch = historySearch.reversed.toSet().toList();
      final saveListHistorySearch = HistorySearchEntity(
        keywords: [
          ...reversedHistorySearch,
          keyword.trim(),
        ].reversed.toSet().toList(),
      );
      _state = _state.copyWith(
        historySearch: HistorySearchEntity(
          keywords: saveListHistorySearch.keywords.take(10).toList(),
        ),
      );
      notifyListeners();
      _saveHistorySearch.call(saveListHistorySearch);
    } catch (e) {
      debugPrint('error save history search: $e');
    }
  }

  @override
  HistorySearchEntity get historySearch => _state.historySearch;

  @override
  bool validateKeyWord(String keyword) {
    return keyword.isEmpty ? false : true;
  }

  @override
  void refreshState() {
    _state = SearchSharedState.initial();
  }
}
