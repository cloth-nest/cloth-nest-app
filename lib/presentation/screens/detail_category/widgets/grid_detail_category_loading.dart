import 'package:ecommerce/presentation/screens/detail_category/widgets/item_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class GridDetailCategoryLoading extends StatelessWidget {
  const GridDetailCategoryLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final rowSizes = List.generate(10 ~/ 2, (_) => auto);

    return SingleChildScrollView(
      child: LayoutGrid(
        columnSizes: [1.fr, 1.fr],
        // set all the row sizes to auto (self-sizing height)
        rowSizes: rowSizes,
        rowGap: 20,
        columnGap: 2, // equivalent to crossAxisSpacing
        children: [
          for (var i = 0; i < 10; i++) const ItemProductLoading(),
        ],
      ),
    );
  }
}
