import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductName extends StatelessWidget {
  const WProductName({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return Padding(
        padding:
            EdgeInsets.only(left: marginSide, right: marginSide, bottom: 10),
        child: Text(
          presenter.name,
          style: Theme.of(context).textTheme.displayMedium,
        ));
  }
}
