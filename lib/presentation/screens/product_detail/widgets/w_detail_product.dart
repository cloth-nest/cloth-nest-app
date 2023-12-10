import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_buttons.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_colors.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_description.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_name.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_price.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_sizes.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_tabbar.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_thumbnail.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_vertical_list_recommends.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_vertical_list_reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class WDetailProduct extends StatefulWidget {
  const WDetailProduct({super.key});

  @override
  State<WDetailProduct> createState() => _WDetailProductState();
}

class _WDetailProductState extends State<WDetailProduct>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ProductDetailPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<ProductDetailPresenter>();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(changeTab);
  }

  void changeTab() {
    presenter.setTabIndex(_tabController.index);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(changeTab);
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _marginSide = 20.0;

    return Column(
      children: [
        const WProductThumbNail(),
        const SizedBox(height: 20),
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 5.0)),

              /// Name
              const SliverToBoxAdapter(
                child: WProductName(
                  marginSide: _marginSide,
                ),
              ),

              /// Price
              const SliverToBoxAdapter(
                child: WProductPrice(
                  marginSide: _marginSide,
                ),
              ),

              /// Colors
              const SliverToBoxAdapter(
                child: WProductColors(
                  marginSide: _marginSide,
                ),
              ),

              /// Sizes
              const SliverToBoxAdapter(
                child: WProductSizes(
                  marginSide: _marginSide,
                ),
              ),

              /// Buttons
              const SliverToBoxAdapter(
                child: WProductButtons(
                  marginSide: _marginSide,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              /// Description
              const SliverToBoxAdapter(
                child: WProductDescription(
                  marginSide: _marginSide,
                ),
              ),

              /// Tab bar
              SliverToBoxAdapter(
                child: WProductTabbar(
                  marginSide: _marginSide,
                  tabController: _tabController,
                ),
              ),

              SliverToBoxAdapter(
                child: Selector<ProductDetailPresenter, int>(
                  selector: (_, presenter) => presenter.tabIndex,
                  builder: (_, tabIndex, __) => tabIndex == 0
                      ? const WVerticalListRecommends()
                      : const WVericalListReviews(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 230)),
            ],
          ),
        ),
      ],
    );
  }
}
