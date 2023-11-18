import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/account/widgets/notification_dot.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/filter_bottom_sheet.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/item_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WFilter extends StatelessWidget {
  const WFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
    final colors = [
      'Red',
      'Orange',
      'Yellow',
      'Green',
      'Blue',
      'Purple',
      'Pink',
      'Brown',
      'White',
      'Grey',
      'Black',
      'Multi-Colour'
    ];
    final prices = [
      'Below 100.000đ',
      '100.000đ - 200.000đ',
      '200.000đ - 300.000đ',
      '300.000đ - 500.000đ',
      'Above 500.000đ',
    ];

    final _presenter = context.read<DetailCategoryPresenter>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Text(
              'Filter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 13,
                    height: 21 / 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.skyPerfectBlue,
                  ),
            ),
            Selector<DetailCategoryPresenter, bool>(
              selector: (_, presenter) => presenter.hasFilter,
              builder: (_, hasFilter, __) => hasFilter
                  ? const Positioned(
                      right: -7,
                      child: NotificationDot(size: 7),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Selector<DetailCategoryPresenter, List<Map<String, dynamic>>>(
          selector: (_, presenter) => presenter.selectedSizes,
          builder: (_, selectedSizes, __) => ItemFilter(
            filter: 'Size',
            isActive: selectedSizes.isNotEmpty ? true : false,
            callback: () async {
              final result = await showBottomSheet(
                context,
                child: FilterBottomSheet(
                  contents: sizes,
                  titleFilter: 'Size',
                  selectedValues: [..._presenter.selectedSizes],
                ),
              );
              if (result != null) {
                _presenter
                    .setSelectedSizes(result as List<Map<String, dynamic>>);
              }
            },
          ),
        ),
        const SizedBox(width: 20),
        Selector<DetailCategoryPresenter, List<Map<String, dynamic>>>(
          selector: (_, presenter) => presenter.selectedColors,
          builder: (_, selectedColors, __) => ItemFilter(
            filter: 'Color',
            isActive: selectedColors.isNotEmpty ? true : false,
            callback: () async {
              final result = await showBottomSheet(
                context,
                child: FilterBottomSheet(
                  contents: colors,
                  titleFilter: 'Color',
                  selectedValues: [..._presenter.selectedColors],
                ),
              );
              if (result != null) {
                _presenter
                    .setSelectedColors(result as List<Map<String, dynamic>>);
              }
            },
          ),
        ),
        const SizedBox(width: 20),
        Selector<DetailCategoryPresenter, List<Map<String, dynamic>>>(
          selector: (_, presenter) => presenter.selectedPrices,
          builder: (_, selectedPrices, __) => ItemFilter(
            filter: 'Price',
            isActive: selectedPrices.isNotEmpty ? true : false,
            callback: () async {
              final result = await showBottomSheet(
                context,
                child: FilterBottomSheet(
                  contents: prices,
                  titleFilter: 'Price',
                  selectedValues: [..._presenter.selectedPrices],
                ),
              );
              if (result != null) {
                _presenter
                    .setSelectedPrices(result as List<Map<String, dynamic>>);
              }
            },
          ),
        ),
      ],
    );
  }

  Future showBottomSheet(BuildContext context, {required Widget child}) {
    return showRoundedBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      radius: 10,
      backgroundColor: Colors.transparent,
      child: child,
    );
  }
}
