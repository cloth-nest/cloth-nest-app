import 'package:ecommerce/app/factories/usecases/detail_product/detail_product_factory.dart';
import 'package:ecommerce/presentation/presenters/product_detail/product_detail_state.dart';
import 'package:ecommerce/presentation/presenters/product_detail/provider_product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';

import '../../usecases/recommendation_product/recommendation_product_factory.dart';

ProductDetailPresenter makeProductDetailPresenter() =>
    ProviderProductDetailPresenter(
      state: ProductDetailState.initial(),
      fetchDetailProduct: makeFetchDetailProduct(),
      fetchRecommendationProduct: makeFetchRecommendationProduct(),
    );
