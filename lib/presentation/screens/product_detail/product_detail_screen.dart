import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_buttons.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_description.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_price.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_tabbar.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_thumbnail.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_product_name.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_vertical_list_recommends.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_vertical_list_reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static const _marginSide = 20.0;
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: SvgPicture.asset(
              SvgPaths.iconArrowLeft,
            ),
            onPressed: () {
              if (context.canPopBeamLocation) {
                context.popBeamLocation();
              }
            },
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
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
          ),
        ),
      ),
    );
  }
}
