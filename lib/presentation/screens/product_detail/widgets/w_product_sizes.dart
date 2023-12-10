import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductSizes extends StatelessWidget {
  final double marginSide;

  const WProductSizes({
    super.key,
    required this.marginSide,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return Selector<ProductDetailPresenter, String>(
      selector: (_, presenter) => presenter.selectedSize,
      builder: (_, selectedSize, __) => Padding(
        padding: EdgeInsets.only(
          left: marginSide,
          right: marginSide,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size: ${selectedSize.toUpperCase()}',
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
                ...presenter.sizes
                    .map(
                      (e) => _buildItemSize(
                        e,
                        isSelected:
                            selectedSize.toLowerCase() == e.toLowerCase(),
                        callback: (size) {
                          presenter.setSelectedSize(size: size);
                        },
                        context: context,
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

Widget _buildItemSize(
  String size, {
  bool isSelected = false,
  required Function(String) callback,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      callback.call(size);
    },
    child: Container(
      decoration: BoxDecoration(
        border: isSelected ? Border.all() : Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: isSelected ? null : Border.all(color: AppColors.lineBasic),
          color: isSelected ? Colors.black : Colors.white,
        ),
        child: Center(
          child: Text(
            size.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    ),
  );
}
