// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';

class TopState {
  final TextEditingController searchController;
  final bool isShowButton;
  final int currentTabIndex;
  final List<MyListEntity> products;
  final List<MyListEntity> myListProducts;

  TopState({
    required this.searchController,
    required this.isShowButton,
    required this.currentTabIndex,
    required this.products,
    required this.myListProducts,
  });

  TopState copyWith({
    TextEditingController? searchController,
    bool? isShowButton,
    int? currentTabIndex,
    List<MyListEntity>? products,
    List<MyListEntity>? myListProducts,
  }) {
    return TopState(
      searchController: searchController ?? this.searchController,
      isShowButton: isShowButton ?? this.isShowButton,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      products: products ?? this.products,
      myListProducts: myListProducts ?? this.myListProducts,
    );
  }

  factory TopState.initial() {
    return TopState(
      searchController: TextEditingController(),
      isShowButton: false,
      currentTabIndex: 0,
      products: [
        MyListEntity(
          thumbnail:
              'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/462770/item/vngoods_56_462770.jpg?width=250',
          name: 'Reversible Stand Jacket',
          id: '462770',
          color: '56 OLIVE',
          size: 'Men',
          price: '1.962.000 VND',
        ),
        MyListEntity(
          thumbnail:
              'https://image.uniqlo.com/UQ/ST3/vn/imagesgoods/462529/item/vngoods_15_462529.jpg?width=250',
          name: 'Pocketable UV Protection Parka (3D Cut)',
          id: '462529',
          color: '15 RED',
          size: 'Men',
          price: '980.000 VND',
        ),
      ],
      myListProducts: [],
    );
  }
}
