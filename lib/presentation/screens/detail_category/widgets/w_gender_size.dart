import 'package:flutter/material.dart';

class WGenderSize extends StatelessWidget {
  final String category;
  final String size;

  const WGenderSize({
    super.key,
    required this.category,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 12,
                height: 21 / 12,
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          size,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 12,
                height: 21 / 12,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
