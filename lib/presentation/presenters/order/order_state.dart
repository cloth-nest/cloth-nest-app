// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:flutter/material.dart';

class OrderState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final ScrollController controller;
  final bool canLoadMore;
  final bool isLoadingMore;

  OrderState({
    required this.isLoading,
    required this.orders,
    required this.controller,
    required this.canLoadMore,
    required this.isLoadingMore,
  });

  factory OrderState.initial() => OrderState(
        isLoading: false,
        orders: [],
        controller: ScrollController(),
        canLoadMore: false,
        isLoadingMore: false,
      );

  OrderState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    ScrollController? controller,
    bool? canLoadMore,
    bool? isLoadingMore,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      controller: controller ?? this.controller,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
