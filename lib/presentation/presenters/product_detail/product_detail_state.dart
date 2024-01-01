// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/review/review_entity.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';

class ProductDetailState {
  final int activePage;
  final PageController pageController;
  final int tabIndex;
  final DetailProductEntity? entity;
  final bool isLoading;
  final List<ProductEntity> recommendationProducts;
  final String selectedColor;
  final String selectedSize;
  final bool isFavorite;
  final bool? successAddToCart;
  final List<ReviewEntity> reviews;

  ProductDetailState(
      {required this.activePage,
      required this.pageController,
      required this.tabIndex,
      this.entity,
      required this.isLoading,
      required this.recommendationProducts,
      required this.selectedColor,
      required this.selectedSize,
      required this.isFavorite,
      required this.successAddToCart,
      required this.reviews});

  factory ProductDetailState.initial() {
    return ProductDetailState(
      activePage: 0,
      pageController: PageController(
        viewportFraction: 1,
        keepPage: true,
        initialPage: 0,
      ),
      tabIndex: 0,
      isLoading: false,
      recommendationProducts: [],
      selectedColor: '',
      selectedSize: '',
      isFavorite: false,
      successAddToCart: false,
      reviews: [],
    );
  }

  ProductDetailState copyWith({
    int? activePage,
    PageController? pageController,
    int? tabIndex,
    DetailProductEntity? entity,
    bool? isLoading,
    List<ProductEntity>? recommendationProducts,
    String? selectedColor,
    String? selectedSize,
    bool? isFavorite,
    bool? successAddToCart,
    List<ReviewEntity>? reviews,
  }) {
    return ProductDetailState(
      activePage: activePage ?? this.activePage,
      pageController: pageController ?? this.pageController,
      tabIndex: tabIndex ?? this.tabIndex,
      entity: entity ?? this.entity,
      isLoading: isLoading ?? this.isLoading,
      recommendationProducts:
          recommendationProducts ?? this.recommendationProducts,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      isFavorite: isFavorite ?? this.isFavorite,
      successAddToCart: successAddToCart,
      reviews: reviews ?? this.reviews,
    );
  }
}
