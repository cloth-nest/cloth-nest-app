import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/usecases/order_detail/fetch_order_detail.dart';
import 'package:ecommerce/presentation/presenters/order_detail/order_detail_state.dart';
import 'package:ecommerce/presentation/screens/order_detail/order_detail_presenter.dart';
import 'package:flutter/material.dart';

class ProviderOrderDetailPresenter
    with ChangeNotifier
    implements OrderDetailPresenter {
  OrderDetailState _state;
  final FetchOrderDetail _fetchOrderDetail;

  ProviderOrderDetailPresenter({
    required OrderDetailState state,
    required FetchOrderDetail fetchOrderDetail,
  })  : _state = state,
        _fetchOrderDetail = fetchOrderDetail;

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
}
