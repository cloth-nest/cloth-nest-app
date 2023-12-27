import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:flutter/material.dart';

abstract class OrderDetailPresenter implements ChangeNotifier {
  bool get isLoading;
  OrderEntity? get order;
  String get createdAt;

  void initData({required int idOrder});
}
