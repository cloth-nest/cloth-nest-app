// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TopState {
  final TextEditingController searchController;
  final bool isShowButton;
  final int currentTabIndex;

  TopState({
    required this.searchController,
    required this.isShowButton,
    required this.currentTabIndex,
  });

  TopState copyWith({
    TextEditingController? searchController,
    bool? isShowButton,
    int? currentTabIndex,
  }) {
    return TopState(
      searchController: searchController ?? this.searchController,
      isShowButton: isShowButton ?? this.isShowButton,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  factory TopState.initial() {
    return TopState(
      searchController: TextEditingController(),
      isShowButton: false,
      currentTabIndex: 0,
    );
  }
}
