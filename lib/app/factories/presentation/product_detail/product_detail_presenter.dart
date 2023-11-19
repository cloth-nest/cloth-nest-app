import 'package:ecommerce/presentation/presenters/product_detail/product_detail_state.dart';
import 'package:ecommerce/presentation/presenters/product_detail/provider_product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';

ProductDetailPresenter makeProductDetailPresenter() =>
    ProviderProductDetailPresenter(
      state: ProductDetailState.initial(),
    );
