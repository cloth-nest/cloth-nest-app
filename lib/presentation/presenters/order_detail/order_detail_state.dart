// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/order/order_entity.dart';

class OrderDetailState {
  final bool isLoading;
  final OrderEntity? order;
  final String? errorMessage;
  final bool isLoadingCancel;

  OrderDetailState({
    required this.isLoading,
    this.order,
    this.errorMessage,
    required this.isLoadingCancel,
  });

  factory OrderDetailState.initial() => OrderDetailState(
        isLoading: false,
        isLoadingCancel: false,
      );

  OrderDetailState copyWith({
    bool? isLoading,
    OrderEntity? order,
    String? errorMessage,
    bool? isLoadingCancel,
  }) {
    return OrderDetailState(
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
      errorMessage: errorMessage,
      isLoadingCancel: isLoadingCancel ?? this.isLoadingCancel,
    );
  }
}
