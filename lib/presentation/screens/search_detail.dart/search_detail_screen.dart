import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/search_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/widgets/w_list_search.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/widgets/w_list_search_loading.dart';
import 'package:ecommerce/presentation/screens/search_shared/search_shared_presenter.dart';
import 'package:ecommerce/presentation/widgets/text_field/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDetailScreen extends StatefulWidget {
  final String keyword;

  const SearchDetailScreen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  late SearchDetailPresenter _presenter;
  late SearchSharedPresenter _searchSharedPresenter;

  String get initialSearchKey => widget.keyword;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<SearchDetailPresenter>();
    _searchSharedPresenter = context.read<SearchSharedPresenter>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_searchSharedPresenter.validateKeyWord(initialSearchKey)) {
        _searchSharedPresenter.searchController.text = initialSearchKey;
        _searchSharedPresenter.onKeywordChanged(initialSearchKey);
        _searchSharedPresenter.saveKeyword(initialSearchKey);
        _presenter.search(initialSearchKey);
      }
    });
  }

  void _handleSearch(String keyword) {
    _searchSharedPresenter.searchController.text = keyword;
    if (_searchSharedPresenter.validateKeyWord(keyword)) {
      _searchSharedPresenter.saveKeyword(keyword);
      _presenter.search(keyword);
    } else {
      _searchSharedPresenter.searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (context.canPopBeamLocation) {
              context.popBeamLocation();
            }
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Selector<SearchSharedPresenter, bool>(
              selector: (_, presenter) => presenter.isShowButton,
              builder: (__, isShowButton, _) => SearchTextField(
                searchController: _searchSharedPresenter.searchController,
                onClearButton: _searchSharedPresenter.onClearText,
                onSubmitSearch: _handleSearch,
                onPressedBtnSearch: _handleSearch,
                isShowButton: isShowButton,
                onChanged: _searchSharedPresenter.onKeywordChanged,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Selector<SearchDetailPresenter, bool>(
              selector: (BuildContext context, presenter) =>
                  presenter.isLoading,
              builder: (_, isLoading, __) =>
                  isLoading ? const WListSearchLoading() : const WListSearch(),
            ),
          ),
        ],
      ),
    );
  }
}
