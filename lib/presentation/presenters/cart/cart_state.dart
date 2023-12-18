// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';

class CartState {
  final List<CartEntity> carts;
  final bool isLoading;

  CartState({
    required this.carts,
    required this.isLoading,
  });

  CartState copyWith({
    List<CartEntity>? carts,
    bool? isLoading,
  }) {
    return CartState(
      carts: carts ?? this.carts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory CartState.initial() => CartState(
        carts: [],
        isLoading: false,
      );
}
