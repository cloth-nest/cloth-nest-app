// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/order/order_entity.dart';

class OrderDetailState {
  final bool isLoading;
  final OrderEntity? order;

  OrderDetailState({
    required this.isLoading,
    this.order,
  });

  factory OrderDetailState.initial() => OrderDetailState(isLoading: false);

  OrderDetailState copyWith({
    bool? isLoading,
    OrderEntity? order,
  }) {
    return OrderDetailState(
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
    );
  }
}
