import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/order/order_presenter.dart';
import 'package:ecommerce/presentation/screens/order/widgets/list_orders_loading.dart';
import 'package:ecommerce/presentation/screens/order/widgets/w_item_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final bool isCanBack;
  const OrderScreen({
    super.key,
    this.isCanBack = false,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<OrderPresenter>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.initData();
    });

    presenter.controller.addListener(presenter.scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    presenter.controller.removeListener(presenter.scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.isCanBack
            ? Container(
                padding: const EdgeInsets.only(left: 12),
                child: IconButton(
                  icon: SvgPicture.asset(
                    SvgPaths.iconArrowLeft,
                  ),
                  onPressed: () {
                    beamTo(context, path: 'cart');
                  },
                ),
              )
            : null,
        title: const Text(
          'Order History',
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textLightBasic,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.3,
      ),
      body: Selector<OrderPresenter, bool>(
        selector: (_, presenter) => presenter.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? const ListOrdersLoading()
            : RefreshIndicator(
                onRefresh: () async {
                  presenter.pullToRefresh();
                },
                child: Selector<OrderPresenter, bool>(
                  selector: (_, presenter) => presenter.isGetMore,
                  builder: (_, isGetMore, __) => CustomScrollView(
                    controller: presenter.controller,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              onTap: () {
                                beamTo(context,
                                    path:
                                        'detail?idOrder=${presenter.orders[index].id}');
                              },
                              child: WItemOrder(
                                order: presenter.orders[index],
                              ),
                            );
                          },
                          childCount: presenter.orders.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: isGetMore
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
