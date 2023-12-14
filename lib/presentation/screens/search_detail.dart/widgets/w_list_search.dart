import 'package:beamer/beamer.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/search_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/widgets/item_search.dart';
import 'package:ecommerce/presentation/screens/search_shared/search_shared_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WListSearch extends StatefulWidget {
  const WListSearch({super.key});

  @override
  State<WListSearch> createState() => _WListSearchState();
}

class _WListSearchState extends State<WListSearch> {
  final ScrollController _scrollController = ScrollController();
  late SearchDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<SearchDetailPresenter>();
    // because of 'reverse:true', list content not display on top,
    // try scroll to top
    _scrollToTop();
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final keyword =
            context.read<SearchSharedPresenter>().searchController.text;

        _presenter.onRefresh(keyword);
      },
      child: CustomScrollView(
        shrinkWrap: true,
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          Selector<SearchDetailPresenter, List<ProductEntity>>(
            selector: (_, presenter) => presenter.searchProducts,
            builder: (_, searchProducts, __) => searchProducts.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ItemSearch(
                          onTap: (entity) {
                            final String currentLocation = context
                                    .currentBeamLocation
                                    .state
                                    .routeInformation
                                    .location ??
                                '/';
                            final uri = Uri.parse(currentLocation);
                            context.beamToNamed(
                                '${uri.path}/product?idProduct=${entity.id}');
                          },
                          entity: searchProducts[index],
                        );
                      },
                      childCount: searchProducts.length,
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        '結果がありません',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )),
                  ),
          ),
        ],
      ),
    );
  }
}
