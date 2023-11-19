import 'package:flutter/material.dart';

class WProductDescription extends StatelessWidget {
  const WProductDescription({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: marginSide,
        right: marginSide,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Text(
            '• Chất liệu: Cotton 2 chiều.',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            '• Regular Fit.',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            '• Hình in trên mặt trước và sau áp áp dụng công nghệ in kéo lụa.',
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
