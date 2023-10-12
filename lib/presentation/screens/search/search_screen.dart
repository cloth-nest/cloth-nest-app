import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/search/search_presenter.dart';
import 'package:ecommerce/presentation/screens/search/widgets/history_search_tags.dart';
import 'package:ecommerce/presentation/screens/search/widgets/vertical_list_categories.dart';
import 'package:ecommerce/presentation/widgets/text_field/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late SearchPresenter _searchPresenter;

  @override
  void initState() {
    super.initState();
    _searchPresenter = context.read<SearchPresenter>();
  }

  @override
  Widget build(BuildContext context) {
    return SearchScreen(
      presenter: _searchPresenter,
    );
  }
}

class SearchScreen extends StatefulWidget {
  final SearchPresenter presenter;

  const SearchScreen({
    super.key,
    required this.presenter,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController _tabController;
  late final ContentMasterPresenter contentMasterPresenter;
  late final SearchPresenter searchPresenter;

  @override
  void initState() {
    super.initState();
    contentMasterPresenter = context.read<ContentMasterPresenter>();
    searchPresenter = context.read<SearchPresenter>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchPresenter.fetchHistorySearch();
    });

    _tabController = TabController(
      length: contentMasterPresenter.searchCategories.length,
      vsync: this,
    );
    _tabController.addListener(onChangeTabListener);
  }

  void onChangeTabListener() {
    widget.presenter.changeTab(
      _tabController.index,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter.refreshState();
    _tabController.removeListener(onChangeTabListener);
  }

  void _goToSearchResult(String keyword) {
    if (searchPresenter.validateKeyWord(keyword)) {
      searchPresenter.saveKeyword(keyword);
      context.beamToNamed('search/result?keyword=$keyword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Selector<SearchPresenter, bool>(
          selector: (_, presenter) => presenter.isShowButton,
          builder: (__, isShowButton, _) => SearchTextField(
            searchController: widget.presenter.searchController,
            onClearButton: widget.presenter.onClearText,
            onSubmitSearch: (value) {
              _goToSearchResult(value);
            },
            onPressedBtnSearch: (value) {
              _goToSearchResult(value);
            },
            isShowButton: isShowButton,
            onChanged: widget.presenter.onKeywordChanged,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Selector<SearchPresenter, HistorySearchEntity>(
                selector: (_, presenter) => presenter.historySearch,
                builder: (_, historySearch, __) => HistorySearchTags(
                  tags: historySearch.keywords,
                  onTap: (keyword) {
                    context.beamToNamed('search/result?keyword=$keyword');
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            TabBar(
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
              controller: _tabController,
              indicatorColor: AppColors.black,
              labelColor: AppColors.textLightBasic,
              labelStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
              labelPadding: const EdgeInsets.only(bottom: 10),
              unselectedLabelColor: AppColors.textGray999,
              tabs: contentMasterPresenter.searchCategories
                  .map((e) => Text(e.name.toUpperCase()))
                  .toList(),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Selector<SearchPresenter, int>(
                selector: (_, searchPresenter) => searchPresenter.tabIndex,
                builder: (_, tabIndex, __) {
                  final subCategories = contentMasterPresenter
                      .searchCategories[tabIndex].subCategory;

                  return VerticalListCategories(
                    categories: subCategories,
                    index: tabIndex,
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
