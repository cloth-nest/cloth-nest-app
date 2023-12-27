import 'package:ecommerce/app/factories/usecases/order_detail/order_detail_factory.dart';
import 'package:ecommerce/presentation/presenters/order_detail/order_detail_state.dart';
import 'package:ecommerce/presentation/presenters/order_detail/provider_order_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/order_detail/order_detail_presenter.dart';

OrderDetailPresenter makeOrderDetailPresenter() => ProviderOrderDetailPresenter(
      state: OrderDetailState.initial(),
      fetchOrderDetail: makeFetchOrderDetail(),
    );
