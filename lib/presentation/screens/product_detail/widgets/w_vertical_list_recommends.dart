import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product.dart';
import 'package:flutter/material.dart';

class WVerticalListRecommends extends StatelessWidget {
  const WVerticalListRecommends({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (BuildContext _, int index) {
        return const WProduct();
      },
    );
  }
}
