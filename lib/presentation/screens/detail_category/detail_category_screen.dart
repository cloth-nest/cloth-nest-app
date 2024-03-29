import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/grid_detail_category.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/grid_detail_category_loading.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/w_filter.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/w_sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailCategoryScreen extends StatefulWidget {
  final String title;
  final int id;

  const DetailCategoryScreen({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<DetailCategoryScreen> createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController _tabController;
  late DetailCategoryPresenter _presenter;
  late ContentMasterPresenter contentMasterPresenter;
  late List<CategoryEntity> categories;

  @override
  void initState() {
    super.initState();
    contentMasterPresenter = context.read<ContentMasterPresenter>();

    categories = contentMasterPresenter.secondCategories['${widget.id}'];
    _tabController = TabController(
      length: categories.length,
      vsync: this,
    );
    _presenter = context.read<DetailCategoryPresenter>();
    _tabController.addListener(onChangeTabListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.initData(id: categories[0].id, page: 1, limit: 6);
    });
  }

  void onChangeTabListener() {
    _presenter.changeTab(
      _tabController.index,
      limit: 6,
      page: 1,
      id: categories[_tabController.index].id,
    );
  }

  @override
  void dispose() {
    super.dispose();
    //topPresenter.refreshState();
    _tabController.removeListener(onChangeTabListener);
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          widget.title.toUpperCase(),
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                border: const Border(
                  bottom: BorderSide(
                    color: AppColors.lineBasic,
                    width: 0.8,
                  ),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                indicatorPadding: const EdgeInsets.only(right: 15),
                controller: _tabController,
                indicatorColor: AppColors.black,
                labelColor: AppColors.textLightBasic,
                labelStyle:
                    Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                labelPadding: const EdgeInsets.only(
                  bottom: 10,
                  right: 15,
                ),
                unselectedLabelColor: AppColors.textGray999,
                tabs:
                    categories.map((e) => Text(e.name.toUpperCase())).toList(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const WSort(),
          const SizedBox(height: 10),
          const WFilter(),
          const SizedBox(height: 15),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await _presenter.pullToRefresh();
              },
              child: Selector<DetailCategoryPresenter, int>(
                selector: (_, presenter) => presenter.tabIndex,
                builder: (_, tabIndex, __) =>
                    Selector<DetailCategoryPresenter, bool>(
                        selector: (_, presenter) => presenter.isLoading,
                        builder: (_, isLoading, __) {
                          return isLoading
                              ? const GridDetailCategoryLoading()
                              : GridDetailCategory(
                                  index: tabIndex,
                                );
                        }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
