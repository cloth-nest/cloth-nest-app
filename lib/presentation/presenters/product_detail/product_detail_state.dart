// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProductDetailState {
  final int activePage;
  final PageController pageController;
  final int tabIndex;

  ProductDetailState({
    required this.activePage,
    required this.pageController,
    required this.tabIndex,
  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
        activePage: 0,
        pageController: PageController(
          viewportFraction: 1,
          keepPage: true,
          initialPage: 0,
        ),
        tabIndex: 0);
  }

  ProductDetailState copyWith({
    int? activePage,
    PageController? pageController,
    int? tabIndex,
  }) {
    return ProductDetailState(
      activePage: activePage ?? this.activePage,
      pageController: pageController ?? this.pageController,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}
