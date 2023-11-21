import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/presentation/screens/top/widgets/item_vertical_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class GridCategories extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int index;
  final Function(String, int) callback;

  const GridCategories({
    super.key,
    required this.categories,
    required this.index,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final rowSizes = List.generate(categories.length ~/ 0.5, (_) => auto);

    return TweenAnimationBuilder<double>(
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
        children: [
          Text(
            LocaleKeys.featureCategory.tr().toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LayoutGrid(
              columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
              rowSizes: rowSizes,
              children: List<Widget>.generate(
                categories.length,
                (index) {
                  final CategoryEntity category = categories[index];
                  return ItemVerticalCategory(
                    onTap: () {
                      callback.call(category.name, category.id);
                    },
                    category: category.name,
                    categoryThumbUrl: category.categoryThumbUrl,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
