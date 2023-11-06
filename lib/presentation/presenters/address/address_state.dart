// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/address/address_entity.dart';

enum AddressDirection { add, detail }

class AddressState {
  final AddressDirection? navigateTo;
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;

  const AddressState({
    this.navigateTo,
    required this.addresses,
    this.selectedAddress,
  });

  factory AddressState.initial() {
    return const AddressState(
      addresses: [],
    );
  }

  AddressState copyWith({
    AddressDirection? navigateTo,
    List<AddressEntity>? addresses,
    AddressEntity? selectedAddress,
  }) {
    return AddressState(
      navigateTo: navigateTo ?? this.navigateTo,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}
