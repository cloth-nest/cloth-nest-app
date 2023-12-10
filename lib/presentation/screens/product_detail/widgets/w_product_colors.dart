import 'package:ecommerce/app/utils/extensions/color_extension.dart';
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_product_entity.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductColors extends StatelessWidget {
  final double marginSide;

  const WProductColors({
    super.key,
    required this.marginSide,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return Selector<ProductDetailPresenter, String>(
      selector: (_, presenter) => presenter.selectedColor,
      builder: (_, selectedColor, __) => Padding(
        padding: EdgeInsets.only(
          left: marginSide,
          right: marginSide,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color: ${selectedColor.toUpperCase()}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(height: 16.71 / 14),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                ...presenter.colors
                    .map(
                      (e) => _buildItemColor(
                        e,
                        isSelected: selectedColor.toLowerCase() ==
                            e.value.toLowerCase(),
                        callback: (color) {
                          presenter.setActivePage(
                              presenter.getOrderImage(color.variantId) ?? 0);
                          presenter.setSelectedColor(colorName: color.value);
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildItemColor(AttributeVariantProductEntity color,
    {bool isSelected = false,
    required Function(AttributeVariantProductEntity) callback}) {
  return GestureDetector(
    onTap: () {
      callback.call(color);
    },
    child: Container(
      decoration: BoxDecoration(
        border: isSelected ? Border.all() : Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        width: 40,
        height: 40,
        color: nameToColor(color.value),
      ),
    ),
  );
}
