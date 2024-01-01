import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:flutter/material.dart';

abstract class OrderDetailPresenter implements ChangeNotifier {
  bool get isLoading;
  OrderEntity? get order;
  String get createdAt;
  String? get errorMessage;
  bool get isCancelLoading;

  void initData({required int idOrder});
  void cancelOrder({required int idOrder});
  void refreshData();
}
