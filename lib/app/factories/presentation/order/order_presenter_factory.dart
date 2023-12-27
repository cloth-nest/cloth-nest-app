import 'package:ecommerce/app/factories/usecases/order/order_factory.dart';
import 'package:ecommerce/presentation/presenters/order/order_state.dart';
import 'package:ecommerce/presentation/presenters/order/provider_order_presenter.dart';
import 'package:ecommerce/presentation/screens/order/order_presenter.dart';

OrderPresenter makeOrderPresenter() => ProviderOrderPresenter(
      state: OrderState.initial(),
      fetchOrder: makeFetchOrder(),
    );
