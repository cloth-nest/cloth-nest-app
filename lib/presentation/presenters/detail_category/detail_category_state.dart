// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/domain/entities/product/product_entity.dart';

class DetailCategoryState extends Equatable {
  final bool isLoading;
  final int tabIndex;
  final List<String> sizes;
  final List<String> colors;
  final List<String> prices;
  final List<Map<String, dynamic>> selectedSizes;
  final List<Map<String, dynamic>> selectedColors;
  final List<Map<String, dynamic>> selectedPrices;
  final String sort;
  final List<ProductEntity> products;
  final int id;
  final int limit;
  final int page;
  final ScrollController controller;
  final bool canGetMore;
  final bool isGetMore;

  DetailCategoryState(
      {required this.isLoading,
      required this.tabIndex,
      required this.sizes,
      required this.colors,
      required this.prices,
      required this.selectedSizes,
      required this.selectedColors,
      required this.selectedPrices,
      required this.sort,
      required this.products,
      required this.id,
      required this.limit,
      required this.page,
      required this.controller,
      required this.canGetMore,
      required this.isGetMore});

  factory DetailCategoryState.initial() {
    return DetailCategoryState(
      isLoading: true,
      tabIndex: 0,
      colors: [],
      sizes: [],
      prices: [],
      selectedColors: [],
      selectedPrices: [],
      selectedSizes: [],
      sort: 'Created descending',
      products: [],
      page: 0,
      id: 0,
      limit: 0,
      controller: ScrollController(),
      isGetMore: false,
      canGetMore: false,
    );
  }

  DetailCategoryState copyWith({
    bool? isLoading,
    int? tabIndex,
    List<String>? sizes,
    List<String>? colors,
    List<String>? prices,
    List<Map<String, dynamic>>? selectedSizes,
    List<Map<String, dynamic>>? selectedColors,
    List<Map<String, dynamic>>? selectedPrices,
    String? sort,
    List<ProductEntity>? products,
    int? id,
    int? limit,
    int? page,
    ScrollController? controller,
    bool? canGetMore,
    bool? isGetMore,
  }) {
    return DetailCategoryState(
      isLoading: isLoading ?? this.isLoading,
      tabIndex: tabIndex ?? this.tabIndex,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      prices: prices ?? this.prices,
      selectedSizes: selectedSizes ?? this.selectedSizes,
      selectedColors: selectedColors ?? this.selectedColors,
      selectedPrices: selectedPrices ?? this.selectedPrices,
      sort: sort ?? this.sort,
      products: products ?? this.products,
      id: id ?? this.id,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      controller: controller ?? this.controller,
      canGetMore: canGetMore ?? this.canGetMore,
      isGetMore: isGetMore ?? this.isGetMore,
    );
  }

  @override
  List<Object?> get props => [products, isLoading];
}
