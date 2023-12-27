// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/entities/bill/bill_entity.dart';
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';

class CheckOutState {
  final bool isLoading;
  final List<CartEntity> carts;
  final AddressEntity? selectedAddress;
  final BillEntity? billEntity;
  final String shippingMethod;
  final List<AddressEntity> addresses;
  final String? navigateTo;

  CheckOutState({
    required this.isLoading,
    required this.carts,
    this.selectedAddress,
    this.billEntity,
    required this.shippingMethod,
    required this.addresses,
    this.navigateTo,
  });

  factory CheckOutState.initial() => CheckOutState(
        isLoading: false,
        carts: [],
        shippingMethod: 'Normal Delivery',
        addresses: [],
      );

  CheckOutState copyWith({
    bool? isLoading,
    List<CartEntity>? carts,
    AddressEntity? selectedAddress,
    BillEntity? billEntity,
    String? shippingMethod,
    List<AddressEntity>? addresses,
    String? navigateTo,
  }) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      carts: carts ?? this.carts,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      billEntity: billEntity ?? this.billEntity,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      addresses: addresses ?? this.addresses,
      navigateTo: navigateTo,
    );
  }
}
