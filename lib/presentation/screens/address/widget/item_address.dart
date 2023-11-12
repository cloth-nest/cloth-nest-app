import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemAddress extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onTap;

  const ItemAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lineBasic,
              width: 1,
            ),
          ),
        ),
        child: ListTile(
          dense: true,
          leading: address.isDefault ?? false
              ? SvgPicture.asset(
                  SvgPaths.iconAddressSelected,
                  width: 20,
                  height: 20,
                )
              : const SizedBox.shrink(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${address.detail}, ${address.wardName}, ${address.districtName}, ${address.provinceName}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
              ),
              Text(
                '${address.lastName} ${address.firstName}, ${address.phone}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
