import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/domain/entities/category/sub_category_entity.dart';
import 'package:ecommerce/presentation/screens/top/widgets/item_vertical_category.dart';
import 'package:ecommerce/presentation/widgets/sliver_grid_delegate.dart';
import 'package:flutter/material.dart';

class GridCategories extends StatelessWidget {
  final List<SubCategoryEntity> categories;
  final int index;

  const GridCategories({
    super.key,
    required this.categories,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                height: 130,
                //childAspectRatio: ((size.width - 50) / 2) / 108,
              ),
              itemBuilder: (BuildContext context, int index) {
                final SubCategoryEntity category = categories[index];

                return ItemVerticalCategory(
                  onTap: () {
                    /// TODO: navigate to detail category
                  },
                  category: category.name,
                  categoryThumbUrl: category.categoryThumbUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
