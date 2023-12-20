import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/w_item_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseAddressScreen extends StatelessWidget {
  final List<AddressEntity> addresses;
  final AddressEntity selectedAddress;
  final Function(AddressEntity) onTap;

  const ChooseAddressScreen({
    super.key,
    required this.addresses,
    required this.selectedAddress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.only(top: 5),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 36,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(60, 60, 67, .3),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Saved Address',
                        style: textTheme.headlineMedium?.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return WItemAddress(
                          address: addresses[index],
                          onTap: () {
                            onTap.call(addresses[index]);
                            Beamer.of(context, root: true).popRoute();
                          },
                          isSelected: selectedAddress.id == addresses[index].id,
                        );
                      },
                      itemCount: addresses.length,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 7,
              child: GestureDetector(
                onTap: () => Beamer.of(context, root: true).popRoute(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  child: SvgPicture.asset(
                    SvgPaths.iconClose,
                    width: 15,
                    height: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
