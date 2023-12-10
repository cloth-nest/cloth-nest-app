import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WVerticalListRecommends extends StatelessWidget {
  const WVerticalListRecommends({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return presenter.recommendationProducts.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: presenter.recommendationProducts.length,
            itemBuilder: (BuildContext _, int index) {
              return WProduct(
                entity: presenter.recommendationProducts[index],
              );
            },
          )
        : Center(
            child: Text(
              'There is no products',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
  }
}
