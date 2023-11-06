import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/screens/address/widget/item_address.dart';
import 'package:flutter/material.dart';

class VerticalListAddresses extends StatelessWidget {
  final List<AddressEntity> addresses;
  final Function(AddressEntity) callback;

  const VerticalListAddresses({
    super.key,
    required this.addresses,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: Column(
          children: addresses.map(
            (address) {
              return ItemAddress(
                onTap: () => callback(address),
                address: address,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
