import 'package:ecommerce/presentation/screens/detail_category/widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class GridDetailCategory extends StatelessWidget {
  // final List<Produc> categories;
  final int index;
  // final Function(String) callback;

  const GridDetailCategory({
    super.key,
    // required this.categories,
    required this.index,
    // required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final rowSizes = List.generate(10 ~/ 2, (_) => auto);

    return TweenAnimationBuilder<double>(
      key: Key(index.toString()),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Scrollbar(
        child: SingleChildScrollView(
          child: LayoutGrid(
            columnSizes: [1.fr, 1.fr],
            // set all the row sizes to auto (self-sizing height)
            rowSizes: rowSizes,
            rowGap: 20,
            columnGap: 2, // equivalent to crossAxisSpacing
            children: [
              for (var i = 0; i < 10; i++) const ItemProduct(),
            ],
          ),
        ),
      ),
    );
  }
}
