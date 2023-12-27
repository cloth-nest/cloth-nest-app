import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:flutter/material.dart';

abstract class OrderPresenter implements ChangeNotifier {
  bool get isLoading;
  List<OrderEntity> get orders;
  ScrollController get controller;
  bool get isGetMore;
  bool get canLoadMore;

  void initData();
  void pullToRefresh();
  void scrollListener();
}
