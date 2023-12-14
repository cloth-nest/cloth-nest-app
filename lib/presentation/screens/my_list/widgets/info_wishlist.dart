import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

class InfoWishlist extends StatelessWidget {
  final ProductEntity entity;

  const InfoWishlist({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entity.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Product ID: ${entity.id}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            entity.price.toMoney(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
