import 'package:flutter/material.dart';

class InfoWishlist extends StatelessWidget {
  const InfoWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reversible Stand Jacket',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Product ID: 462770',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Color: 56 OLIVE',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Size: Men',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            '1.962.000 VND',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
