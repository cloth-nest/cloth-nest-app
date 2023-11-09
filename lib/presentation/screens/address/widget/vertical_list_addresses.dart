import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/screens/address/widget/btn_delete.dart';
import 'package:ecommerce/presentation/screens/address/widget/btn_edit.dart';
import 'package:ecommerce/presentation/screens/address/widget/item_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VerticalListAddresses extends StatelessWidget {
  final List<AddressEntity> addresses;
  final Function(AddressEntity) callback;
  final Function(AddressEntity) onDeleted;

  const VerticalListAddresses({
    super.key,
    required this.addresses,
    required this.callback,
    required this.onDeleted,
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
              return Slidable(
                // The start action pane is the one at the left or the top side.
                endActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    ButtonEdit(
                      onTap: () => callback(address),
                    ),
                    ButtonDelete(
                      onTap: () => onDeleted(address),
                    ),
                  ],
                ),
                child: ItemAddress(
                  onTap: () => callback(address),
                  address: address,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
