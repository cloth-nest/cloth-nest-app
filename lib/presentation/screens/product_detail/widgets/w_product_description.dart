import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductDescription extends StatelessWidget {
  const WProductDescription({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return Padding(
      padding: EdgeInsets.only(
        left: marginSide,
        right: marginSide,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          ...presenter.attributes
              .map((attribute) => Text(
                    '• ${attribute.attributeName}: ${attribute.value}.',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
