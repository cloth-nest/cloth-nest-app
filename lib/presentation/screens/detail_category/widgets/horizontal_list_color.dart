import 'package:ecommerce/presentation/screens/detail_category/widgets/item_color.dart';
import 'package:flutter/material.dart';

class HorizontalListColor extends StatelessWidget {
  final List<Color> colors;
  const HorizontalListColor({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 9.0),
            child: ItemColor(
              color: colors[index],
            ),
          );
        },
        itemCount: colors.length,
      ),
    );
  }
}
