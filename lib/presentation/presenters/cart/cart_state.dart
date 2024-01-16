// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';

class CartState {
  final List<CartEntity> carts;
  final bool isLoading;
  final bool? isAvailable;

  CartState({
    required this.carts,
    required this.isLoading,
    this.isAvailable,
  });

  CartState copyWith({
    List<CartEntity>? carts,
    bool? isLoading,
    bool? isAvailable,
  }) {
    return CartState(
      carts: carts ?? this.carts,
      isLoading: isLoading ?? this.isLoading,
      isAvailable: isAvailable,
    );
  }

  factory CartState.initial() => CartState(
        carts: [],
        isLoading: false,
      );
}
