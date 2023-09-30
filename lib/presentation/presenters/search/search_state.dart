// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:flutter/material.dart';

enum GenderType { women, men, kids, baby }

class SearchState {
  final int currentTabIndex;
  final TextEditingController searchController;
  final bool isShowButton;
  final HistorySearchEntity historySearch;

  SearchState({
    required this.currentTabIndex,
    required this.searchController,
    required this.isShowButton,
    required this.historySearch,
  });

  factory SearchState.initial() {
    return SearchState(
      searchController: TextEditingController(),
      isShowButton: false,
      currentTabIndex: 0,
      historySearch: HistorySearchEntity.initial(),
    );
  }

  SearchState copyWith({
    int? currentTabIndex,
    TextEditingController? searchController,
    bool? isShowButton,
    HistorySearchEntity? historySearch,
  }) {
    return SearchState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      searchController: searchController ?? this.searchController,
      isShowButton: isShowButton ?? this.isShowButton,
      historySearch: historySearch ?? this.historySearch,
    );
  }
}
