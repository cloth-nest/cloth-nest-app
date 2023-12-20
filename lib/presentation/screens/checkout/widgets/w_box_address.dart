import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/box.dart';
import 'package:flutter/material.dart';

class WBoxAddress extends StatelessWidget {
  final AddressEntity address;
  const WBoxAddress({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Box(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(SvgPaths.fakeMap),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.detail,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${address.wardName}, ${address.districtName}, ${address.provinceName}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  address.phone,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
