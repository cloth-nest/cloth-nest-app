import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/domain/entities/detail_order/order_detail_entity.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/presentation/screens/order/widgets/w_item_tag_order.dart';
import 'package:ecommerce/presentation/screens/order_detail/order_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/order_detail/widgets/order_detail_loading.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final int idOrder;

  const OrderDetailScreen({
    super.key,
    required this.idOrder,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderDetailPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<OrderDetailPresenter>();
    presenter.addListener(_onListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.initData(idOrder: widget.idOrder);
    });
  }

  void _onListener() {
    if (presenter.errorMessage != null) {
      if (presenter.errorMessage == 'success') {
        showSnackBar(
          context,
          'Cancel order successfully',
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
        );
      } else {
        showErrorDialog(context, 'Cancel Failed', presenter.errorMessage!);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const WAppBar(title: 'Order Detail'),
      body: Selector<OrderDetailPresenter, bool>(
        selector: (_, presenter) => presenter.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? const OrderDetailLoading()
            : Selector<OrderDetailPresenter, OrderEntity?>(
                selector: (_, presenter) => presenter.order,
                builder: (_, order, __) => order == null
                    ? const SizedBox.shrink()
                    : RefreshIndicator(
                        onRefresh: () async {
                          presenter.refreshData();
                        },
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                height: size.height,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    WItemTagOrder(status: order.status),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: ListView(
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  'Transaction ID',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  order.id.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            _buildDivider(),
                                            Row(
                                              children: [
                                                Text(
                                                  'Customer Name',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '${order.firstName} ${order.lastName}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                              ],
                                            ),
                                            _buildDivider(),
                                            Row(
                                              children: [
                                                Text(
                                                  'Order Date',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  presenter.createdAt,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              'Address',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                    fontSize: 14,
                                                  ),
                                            ),
                                            _buildDivider(),
                                            Text(
                                              order.detail,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                            Text(
                                                '${order.districtName}, ${order.provinceName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall),
                                            Text(order.phone,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall),
                                            _buildDivider(),
                                            const SizedBox(height: 10),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    order.orderDetails.length,
                                                itemBuilder: (context, index) {
                                                  final OrderDetailEntity e =
                                                      order.orderDetails[index];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: e.image,
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                              width: 100,
                                                              height: 100,
                                                              color: AppColors
                                                                  .placeholderLightMode,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                e.name,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall
                                                                    ?.copyWith(
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Quantity: ',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displaySmall
                                                                        ?.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                      e.quantity
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headlineSmall
                                                                          ?.copyWith(
                                                                            fontSize:
                                                                                14,
                                                                          )),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Price: ',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displaySmall
                                                                        ?.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    e.price
                                                                        .toMoney(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headlineSmall
                                                                        ?.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              if (order
                                                                      .status ==
                                                                  'DELIVERED')
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    beamTo(
                                                                        context,
                                                                        path:
                                                                            'reviews?idProduct=${e.idProduct}');
                                                                  },
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: 8.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .edit,
                                                                          size:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        'Send reviews',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .displaySmall
                                                                            ?.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          decoration:
                                                                              TextDecoration.underline,
                                                                          decorationStyle:
                                                                              TextDecorationStyle.dashed,
                                                                          color:
                                                                              Colors.transparent,
                                                                          decorationColor:
                                                                              Colors.black,
                                                                          shadows: [
                                                                            const Shadow(
                                                                                color: Colors.black,
                                                                                offset: Offset(0, -5))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                            _buildDivider(),
                                            Row(
                                              children: [
                                                Text(
                                                  'Sub Total',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(order.subTotal.toMoney(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Delivery Fee',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                    order.shippingFee.toMoney(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Vat Fee',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(order.vatFee.toMoney(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                              ],
                                            ),
                                            _buildDivider(),
                                            Row(
                                              children: [
                                                Text(
                                                  'Total Payment',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Text(order.total.toMoney(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            (order.status != 'DELIVERED' &&
                                                    order.status != 'CANCELED')
                                                ? BRoundButton(
                                                    buttonName: 'Cancel Order',
                                                    onClick: () {
                                                      presenter.cancelOrder(
                                                          idOrder:
                                                              widget.idOrder);
                                                    },
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Selector<OrderDetailPresenter, bool>(
                              selector: (context, presenter) =>
                                  presenter.isCancelLoading,
                              builder: (context, isLoading, _) {
                                if (isLoading) {
                                  return Container(
                                    color: Colors.grey.withOpacity(0.5),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 3,
      color: const Color(0xFFEEEEEE),
    );
  }
}
