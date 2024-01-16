import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_item_stock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WVericalListStocks extends StatelessWidget {
  const WVericalListStocks({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<ProductDetailPresenter>();

    return presenter.warehouses.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: presenter.warehouses.length,
            itemBuilder: (BuildContext _, int index) {
              return WItemStock(
                warehouse: presenter.warehouses[index],
              );
            },
          )
        : Center(
            child: Text(
              'There is no data',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
  }
}
