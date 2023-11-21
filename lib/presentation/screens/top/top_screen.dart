import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/top/top_presenter.dart';
import 'package:ecommerce/presentation/screens/top/widgets/grid_categories.dart';
import 'package:ecommerce/presentation/widgets/text_field/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController _tabController;
  late ContentMasterPresenter contentMasterPresenter;
  late TopPresenter topPresenter;

  @override
  void initState() {
    super.initState();
    contentMasterPresenter = context.read<ContentMasterPresenter>();
    topPresenter = context.read<TopPresenter>();

    _tabController = TabController(
      length: contentMasterPresenter.rootCategories.length,
      vsync: this,
    );

    _tabController.addListener(onChangeTabListener);
  }

  void onChangeTabListener() {
    topPresenter.changeTab(
      _tabController.index,
    );
  }

  @override
  void dispose() {
    super.dispose();
    topPresenter.refreshState();
    _tabController.removeListener(onChangeTabListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Selector<TopPresenter, bool>(
                selector: (_, presenter) => presenter.isShowButton,
                builder: (_, isShowButton, __) => SearchTextField(
                  onChanged: (value) {},
                  searchController: topPresenter.searchController,
                  isShowButton: isShowButton,
                  onClearButton: () {},
                  onSubmitSearch: (value) {},
                  onPressedBtnSearch: (value) {},
                ),
              ),
            ),
            const SizedBox(width: 20),
            Image.asset(
              SvgPaths.iconCart,
              width: 30,
              height: 30,
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TabBar(
              controller: _tabController,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
              indicatorColor: AppColors.black,
              labelColor: AppColors.textLightBasic,
              labelStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
              labelPadding: const EdgeInsets.only(bottom: 10),
              unselectedLabelColor: AppColors.textGray999,
              tabs: contentMasterPresenter.rootCategories
                  .map((e) => Text(e.name.toUpperCase()))
                  .toList(),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Selector<TopPresenter, int>(
                selector: (_, searchPresenter) => searchPresenter.tabIndex,
                builder: (_, tabIndex, __) {
                  final subCategories = contentMasterPresenter
                      .rootCategories[tabIndex].subCategory;

                  return GridCategories(
                    categories: subCategories,
                    index: tabIndex,
                    callback: (titleCategory, id) {
                      beamTo(context,
                          path: 'detail?title=$titleCategory&id=$id');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
