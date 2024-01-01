import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/presentation/screens/search/widgets/item_horizontal_category.dart';
import 'package:flutter/material.dart';

class VerticalListCategories extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int index;

  const VerticalListCategories({
    super.key,
    required this.categories,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: TweenAnimationBuilder<double>(
        key: Key(index.toString()),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: Column(
          children: categories.map(
            (category) {
              return ItemHorizontalCategory(
                onTap: () {
                  beamTo(context,
                      path:
                          'category_detail?title=${category.name}&id=${category.id}');
                },
                category: category.name,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
