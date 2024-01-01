import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/factories/usecases/firebase_token/firebase_token_factory.dart';
import 'package:ecommerce/app/factories/usecases/send_notification/send_notification_factory.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/usecases/cancel_order/fetch_cancel_order.dart';
import 'package:ecommerce/domain/usecases/order_detail/fetch_order_detail.dart';
import 'package:ecommerce/presentation/presenters/order_detail/order_detail_state.dart';
import 'package:ecommerce/presentation/screens/order_detail/order_detail_presenter.dart';
import 'package:flutter/material.dart';

class ProviderOrderDetailPresenter
    with ChangeNotifier
    implements OrderDetailPresenter {
  OrderDetailState _state;
  final FetchOrderDetail _fetchOrderDetail;
  final FetchCancelOrder _fetchCancelOrder;

  ProviderOrderDetailPresenter({
    required OrderDetailState state,
    required FetchOrderDetail fetchOrderDetail,
    required FetchCancelOrder fetchCancelOrder,
  })  : _state = state,
        _fetchOrderDetail = fetchOrderDetail,
        _fetchCancelOrder = fetchCancelOrder;

  @override
  void initData({required int idOrder}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      OrderEntity entity = await _fetchOrderDetail.call(idOrder: idOrder);

      _state = _state.copyWith(
        isLoading: false,
        order: entity,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('##error init data detail order: $e');
    }
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  OrderEntity? get order => _state.order;

  @override
  String get createdAt => DateFormat('dd/MM/yyyy HH:MM')
      .format(DateTime.parse(order?.createdAt ?? '').toLocal());

  @override
  void cancelOrder({required int idOrder}) async {
    try {
      _state = _state.copyWith(isLoadingCancel: true);
      notifyListeners();

      await _fetchCancelOrder.call(idOrder: idOrder);

      final String adminToken =
          await makeFetchFirebaseToken().call(email: 'root@clothnest.vn');

      await makeFetchSendNotification().call(
        name:
            '${_state.order?.firstName} ${_state.order?.lastName} has cancelled an order',
        token: adminToken,
      );

      _state = _state.copyWith(
        isLoadingCancel: false,
        errorMessage: 'success',
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(
        errorMessage: e.toString(),
        isLoadingCancel: false,
      );
      notifyListeners();
      debugPrint('##error cancel order: $e');
    }
  }

  @override
  void refreshData() async {
    initData(idOrder: _state.order?.id ?? -1);
  }

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  bool get isCancelLoading => _state.isLoadingCancel;
}
