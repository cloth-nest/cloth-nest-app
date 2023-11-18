import 'package:flutter/material.dart';

class ItemColor extends StatelessWidget {
  final Color color;
  const ItemColor({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      color: color,
    );
  }
}
