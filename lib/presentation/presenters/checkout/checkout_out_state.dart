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
  final String paymentMethod;
  final List<String> shippingMethods;

  CheckOutState({
    required this.isLoading,
    required this.carts,
    this.selectedAddress,
    this.billEntity,
    required this.shippingMethod,
    required this.addresses,
    this.navigateTo,
    required this.paymentMethod,
    required this.shippingMethods,
  });

  factory CheckOutState.initial() => CheckOutState(
      isLoading: false,
      carts: [],
      shippingMethod: 'Normal Delivery',
      paymentMethod: 'Payment by Cash',
      addresses: [],
      shippingMethods: [
        'Normal Delivery',
        'Fast Delivery',
      ]);

  CheckOutState copyWith({
    bool? isLoading,
    List<CartEntity>? carts,
    AddressEntity? selectedAddress,
    BillEntity? billEntity,
    String? shippingMethod,
    List<AddressEntity>? addresses,
    String? navigateTo,
    String? paymentMethod,
    List<String>? shippingMethods,
  }) {
    return CheckOutState(
      isLoading: isLoading ?? this.isLoading,
      carts: carts ?? this.carts,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      billEntity: billEntity ?? this.billEntity,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      addresses: addresses ?? this.addresses,
      navigateTo: navigateTo,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingMethods: shippingMethods ?? this.shippingMethods,
    );
  }
}
