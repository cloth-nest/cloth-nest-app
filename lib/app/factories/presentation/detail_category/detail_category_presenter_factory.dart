import 'package:ecommerce/presentation/presenters/detail_category/detail_category_state.dart';
import 'package:ecommerce/presentation/presenters/detail_category/provider_detail_category_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';

DetailCategoryPresenter makeDetailCategoryPresenter() =>
    ProviderDetailCategoryPresenter(
      state: DetailCategoryState.initial(),
    );
