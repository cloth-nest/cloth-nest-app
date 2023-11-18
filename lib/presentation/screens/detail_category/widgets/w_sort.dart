import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/short_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WSort extends StatelessWidget {
  final int total;
  const WSort({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<DetailCategoryPresenter>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            '$total product(s)',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 13,
                  height: 21 / 13,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              final result = await showRoundedBottomSheet(
                context: context,
                isScrollControlled: false,
                useSafeArea: false,
                radius: 10,
                child: SortBottomSheet(
                  currentValue: presenter.sort,
                ),
                backgroundColor: Colors.transparent,
              );
              if (result != null) {
                presenter.setSort(result);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  SvgPaths.iconFilter,
                  width: 11,
                  height: 11,
                ),
                const SizedBox(width: 2),
                Text(
                  'Sort',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 13,
                        height: 21 / 13,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
