import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/domain/entities/detail_product/variant_entity.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductPrice extends StatelessWidget {
  const WProductPrice({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginSide,
        right: marginSide,
        bottom: 10,
      ),
      child: Selector<ProductDetailPresenter, VariantEntity>(
        selector: (_, presenter) => presenter.selectedVariantEntity,
        builder: (_, variant, __) => Text(
          variant.price.toMoney(),
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(height: 16.71 / 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
