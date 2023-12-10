import 'package:beamer/beamer.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:provider/provider.dart';

class GridDetailCategory extends StatefulWidget {
  final int index;
  // final Function(String) callback;

  const GridDetailCategory({
    super.key,
    required this.index,
    // required this.callback,
  });

  @override
  State<GridDetailCategory> createState() => _GridDetailCategoryState();
}

class _GridDetailCategoryState extends State<GridDetailCategory> {
  late final DetailCategoryPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<DetailCategoryPresenter>();
    presenter.controller.addListener(presenter.scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    presenter.removeListener(presenter.scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: Key(widget.index.toString()),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Selector<DetailCategoryPresenter, bool>(
        selector: (_, presenter) => presenter.isGetMore,
        builder: (_, isGetMore, __) => CustomScrollView(
          controller: presenter.controller,
          slivers: [
            Selector<DetailCategoryPresenter, List<ProductEntity>>(
                selector: (_, presenter) => presenter.products,
                builder: (_, products, __) {
                  if (products.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'There is no products',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                  final rowSizes =
                      List.generate(products.length + 1 ~/ 2, (_) => auto);
                  return SliverToBoxAdapter(
                    child: LayoutGrid(
                      columnSizes: [1.fr, 1.fr],
                      // set all the row sizes to auto (self-sizing height)
                      rowSizes: rowSizes,
                      rowGap: isGetMore ? 10 : 20,
                      columnGap: 2, // equivalent to crossAxisSpacing
                      children: products.map((e) {
                        return ItemProduct(
                          entity: e,
                          callback: (idProduct) {
                            final String currentLocation = context
                                    .currentBeamLocation
                                    .state
                                    .routeInformation
                                    .location ??
                                '/';
                            final uri = Uri.parse(currentLocation);
                            context.beamToNamed(
                                '${uri.path}/product?idProduct=$idProduct');
                          },
                        );
                      }).toList(),
                    ),
                  );
                }),
            SliverToBoxAdapter(
              child: isGetMore
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
