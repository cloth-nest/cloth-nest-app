import 'package:beamer/beamer.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/item_my_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListSliverList extends StatelessWidget {
  const MyListSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<MyListPresenter, List<ProductEntity>>(
      selector: (_, presenter) => presenter.myListProducts,
      builder: (_, myListProducts, __) => myListProducts.isEmpty
          ? SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'There is no item wishlist',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ItemMyList(
                    onTap: (entity) {
                      final String currentLocation = context.currentBeamLocation
                              .state.routeInformation.location ??
                          '/';
                      final uri = Uri.parse(currentLocation);
                      context.beamToNamed(
                          '${uri.path}/product?idProduct=${entity.id}');
                    },
                    entity: myListProducts[index],
                  );
                },
                childCount: myListProducts.length,
              ),
            ),
    );
  }
}
