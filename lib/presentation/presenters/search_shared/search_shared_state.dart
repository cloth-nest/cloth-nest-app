// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';

class SearchSharedState {
  final TextEditingController searchController;
  final bool isShowButton;
  final HistorySearchEntity historySearch;
  final List<ProductEntity> searchProducts;

  SearchSharedState({
    required this.searchController,
    required this.isShowButton,
    required this.historySearch,
    required this.searchProducts,
  });

  factory SearchSharedState.initial() {
    return SearchSharedState(
      searchController: TextEditingController(),
      isShowButton: false,
      historySearch: HistorySearchEntity.initial(),
      searchProducts: [],
    );
  }

  SearchSharedState copyWith({
    int? currentTabIndex,
    TextEditingController? searchController,
    bool? isShowButton,
    HistorySearchEntity? historySearch,
    List<ProductEntity>? searchProducts,
  }) {
    return SearchSharedState(
      searchController: searchController ?? this.searchController,
      isShowButton: isShowButton ?? this.isShowButton,
      historySearch: historySearch ?? this.historySearch,
      searchProducts: searchProducts ?? this.searchProducts,
    );
  }
}
