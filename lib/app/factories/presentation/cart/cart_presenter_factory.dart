import 'package:ecommerce/app/factories/usecases/cart/cart_factory.dart';
import 'package:ecommerce/presentation/presenters/cart/cart_state.dart';
import 'package:ecommerce/presentation/presenters/cart/provider_cart_presenter.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';

CartPresenter makeCartPresenter() => ProviderCartPresenter(
      state: CartState.initial(),
      fetchCart: makeFetchCart(),
      fetchAddToCart: makeFetchAddToCart(),
      fetchRemoveFromCart: makeFetchRemoveFromCart(),
    );
