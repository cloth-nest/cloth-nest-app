import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductPrice extends StatelessWidget {
  const WProductPrice({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return Padding(
      padding: EdgeInsets.only(
        left: marginSide,
        right: marginSide,
        bottom: 10,
      ),
      child: Text(
        presenter.price.toMoney(),
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(height: 16.71 / 14),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
