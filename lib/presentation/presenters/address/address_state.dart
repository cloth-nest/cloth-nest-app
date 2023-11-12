// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:equatable/equatable.dart';

enum AddressDirection { add, detail }

class AddressState extends Equatable {
  final AddressDirection? navigateTo;
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;
  final String? errorMessage;

  const AddressState({
    this.navigateTo,
    required this.addresses,
    this.selectedAddress,
    this.errorMessage,
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
    String? errorMessage,
  }) {
    return AddressState(
      navigateTo: navigateTo,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [addresses];
}
