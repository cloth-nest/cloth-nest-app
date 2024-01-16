import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_badge.dart';
import 'package:flutter/material.dart';

class WProductTabbar extends StatefulWidget {
  final double marginSide;
  final TabController tabController;

  const WProductTabbar({
    super.key,
    required this.marginSide,
    required this.tabController,
  });

  @override
  State<WProductTabbar> createState() => _WProductTabbarState();
}

class _WProductTabbarState extends State<WProductTabbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.marginSide,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          controller: widget.tabController,
          isScrollable: true,
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
          indicatorColor: AppColors.skyPerfectBlue,
          labelColor: AppColors.skyPerfectBlue,
          unselectedLabelColor: AppColors.textGray999,
          labelStyle: Theme.of(context).textTheme.displaySmall,
          tabs: const <Widget>[
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Related',
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  WProductBadge()
                ],
              ),
            ),
            Tab(
              child: Text(
                'Review',
              ),
            ),
            Tab(
              child: Text(
                'Available',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
