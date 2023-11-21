import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/detail_category/detail_category_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/detail_category/detail_category_view_factory.dart';
import 'package:ecommerce/app/routes/top/top_location.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopCategoryLocation extends BeamLocation<BeamState> {
  TopCategoryLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topLocation = TopLocation();
    final pages = topLocation.buildPages(context, state);
    final title = state.queryParameters['title'] ?? '';
    final id = state.queryParameters['id'] ?? -1;
    final contentMasterPresenter = context.read<ContentMasterPresenter>();
    final List<CategoryEntity> categories =
        contentMasterPresenter.secondCategories['$id'];
    return pages
      ..add(
        BeamPage(
          key: ValueKey('detail-category-$title-$id'),
          child: ChangeNotifierProvider.value(
            value: makeDetailCategoryPresenter(),
            child: makeDetailCategoryView(
              title: title,
              categories: categories,
            ),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/detail?title=:String&id=:id'];
}
