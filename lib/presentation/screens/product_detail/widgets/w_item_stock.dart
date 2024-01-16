import 'package:ecommerce/domain/entities/detail_product/warehouse_stock_entity.dart';
import 'package:flutter/material.dart';

class WItemStock extends StatelessWidget {
  final WarehouseStockEntity warehouse;

  const WItemStock({
    super.key,
    required this.warehouse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              warehouse.warehouse,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 13,
                  ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            warehouse.quantity.toString(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
