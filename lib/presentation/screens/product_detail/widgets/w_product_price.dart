import 'package:flutter/material.dart';

class WProductPrice extends StatelessWidget {
  const WProductPrice({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginSide,
        right: marginSide,
        bottom: 10,
      ),
      child: Text(
        '390.000₫',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(height: 16.71 / 14),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
