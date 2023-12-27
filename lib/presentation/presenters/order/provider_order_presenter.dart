import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/usecases/order/fetch_order.dart';
import 'package:ecommerce/presentation/presenters/order/order_state.dart';
import 'package:ecommerce/presentation/screens/order/order_presenter.dart';
import 'package:flutter/material.dart';

class ProviderOrderPresenter with ChangeNotifier implements OrderPresenter {
  OrderState _state;
  final FetchOrder _fetchOrder;

  ProviderOrderPresenter({
    required OrderState state,
    required FetchOrder fetchOrder,
  })  : _state = state,
        _fetchOrder = fetchOrder;

  int limitItem = 6;
  int page = 1;

  @override
  void initData() async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      List<OrderEntity> orders =
          await _fetchOrder.call(page: 1, limit: limitItem);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        canLoadMore: orders.length >= limitItem,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('##error init data in order: $e');
    }
  }

  @override
  void scrollListener() async {
    if (isGetMore) return;
    if (controller.position.pixels > controller.position.maxScrollExtent - 30 &&
        canLoadMore) {
      try {
        // Update page index
        ++page;
        _state = _state.copyWith(isLoadingMore: true);
        notifyListeners();

        List<OrderEntity> orders =
            await _fetchOrder.call(page: page, limit: limitItem);
        _state = _state.copyWith(
          orders: [..._state.orders, ...orders],
          canLoadMore: orders.length >= limitItem,
        );
        notifyListeners();
      } catch (e) {
        _state = _state.copyWith(isLoadingMore: false);
        rethrow;
      } finally {
        _state = _state.copyWith(isLoadingMore: false);
        notifyListeners();
      }
    }
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  List<OrderEntity> get orders => _state.orders;

  @override
  void pullToRefresh() async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();
      page = 1;
      List<OrderEntity> orders =
          await _fetchOrder.call(page: 1, limit: limitItem);

      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        canLoadMore: orders.length >= limitItem,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('##error init data in order: $e');
    }
  }

  @override
  ScrollController get controller => _state.controller;

  @override
  bool get canLoadMore => _state.canLoadMore;

  @override
  bool get isGetMore => _state.isLoadingMore;
}
