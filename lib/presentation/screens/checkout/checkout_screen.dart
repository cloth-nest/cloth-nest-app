import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/presentation/screens/checkout/checkout_presenter.dart';
import 'package:ecommerce/presentation/screens/checkout/choose_address_screen.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/w_box_address.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/w_checkout_loading.dart';
import 'package:ecommerce/presentation/screens/checkout/widgets/w_shipping_method.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({
    super.key,
  });

  @override
  State<CheckOutScreen> createState() => _SecondCheckOutScreenState();
}

class _SecondCheckOutScreenState extends State<CheckOutScreen> {
  // List<Payment> payments = [
  //   Payment(
  //     img: AppAssets.icCash,
  //     name: 'Payment By Cash',
  //   ),
  //   Payment(
  //     img: AppAssets.icZaloPay,
  //     name: 'Payment By Zalo Pay',
  //   ),
  //   Payment(
  //     img: AppAssets.icVnPay,
  //     name: 'Payment By VN Pay',
  //   )
  // ];
  String namePayment = "Payment By Cash";
  String zpTransToken = "";
  String payResult = "";
  String payAmount = "10000";
  bool showResult = false;
  TextEditingController couponController = TextEditingController();
  late CheckOutPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<CheckOutPresenter>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    couponController.dispose();
  }

  String valueCoupon = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(
        title: 'Checkout',
      ),
      body: Selector<CheckOutPresenter, bool>(
        selector: (_, presenter) => presenter.isLoading,
        builder: (_, isLoading, __) => isLoading
            ? const WCheckoutLoading()
            : ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Destination',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () async {
                      await showRoundedBottomSheet(
                        context: context,
                        isScrollControlled: false,
                        useSafeArea: false,
                        radius: 10,
                        backgroundColor: Colors.transparent,
                        child: ChooseAddressScreen(
                          addresses: presenter.addresses,
                          selectedAddress: presenter.selectedAddress!,
                          onTap: (newAddress) {
                            context
                                .read<CheckOutPresenter>()
                                .setNewAddress(newAddress: newAddress);
                          },
                        ),
                      );
                    },
                    child: Selector<CheckOutPresenter, AddressEntity?>(
                      selector: (_, presenter) => presenter.selectedAddress,
                      builder: (_, selectedAddress, __) =>
                          selectedAddress == null
                              ? const SizedBox.shrink()
                              : WBoxAddress(address: selectedAddress),
                    ),
                  ),
                  _buildDivider(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Total',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDivider(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Order Total',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(height: 21 / 14),
                        ),
                        const Spacer(),
                        Selector<CheckOutPresenter, double>(
                          selector: (_, presenter) => presenter.totalBeforeVAT,
                          builder: (_, totalBeforeVAT, __) => Text(
                            totalBeforeVAT.toMoney(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Deliver Fee',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(height: 21 / 14),
                        ),
                        const Spacer(),
                        Selector<CheckOutPresenter, double>(
                          selector: (_, presenter) => presenter.shippingFee,
                          builder: (_, shippingFee, __) => Text(
                            shippingFee.toMoney(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'VAT',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(height: 21 / 14),
                        ),
                        const Spacer(),
                        Selector<CheckOutPresenter, double>(
                          selector: (_, presenter) => presenter.vatFee,
                          builder: (_, vatFee, __) => Text(
                            vatFee.toMoney(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Total Payment',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(height: 21 / 14),
                        ),
                        const Spacer(),
                        Selector<CheckOutPresenter, double>(
                          selector: (_, presenter) => presenter.total,
                          builder: (_, totalPayment, __) => Text(
                            totalPayment.toMoney(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDivider(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Shipping Method',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Selector<CheckOutPresenter, String>(
                      selector: (_, presenter) => presenter.shippingMethod,
                      builder: (_, shippingMethod, __) => WShippingMethod(
                        callback: (method) {
                          presenter.setShippingMethod(method: method);
                        },
                        source: const [
                          'Fast Delivery',
                          'Normal Delivery',
                        ],
                        value: shippingMethod,
                        hint: 'Shipping Method',
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: TextFieldInput(
                  //           hintText: 'Coupon Code',
                  //           controller: couponController,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Expanded(
                  //         child: CustomButton(
                  //           margin: 0,
                  //           width: 0,
                  //           content: 'Apply',
                  //           onTap: () {
                  //             _bloc.add(CouponChecked(
                  //               couponCode: couponController.text.trim(),
                  //               productList: widget.carts
                  //                   .map((x) => {
                  //                         'id': x.product.id,
                  //                         'quantity': x.quantity,
                  //                       })
                  //                   .toList(),
                  //             ));
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 10),
                  _buildDivider(),
                  const SizedBox(height: 10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Text(
                  //     'Choose Payment Method',
                  //     style: AppStyles.medium,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Wrap(
                  //     // spacing: 10,
                  //     // direction: Axis.vertical,
                  //     children: payments
                  //         .map(
                  //           (e) => GestureDetector(
                  //             onTap: () {
                  //               setState(() {
                  //                 namePayment = e.name;
                  //               });
                  //             },
                  //             child: ItemPaymentMethod(
                  //               payment: e,
                  //               isPicked: namePayment == e.name,
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      left: 20,
                      right: 20,
                    ),
                    child: BRoundButton(
                      buttonName: 'Checkout',
                      onClick: () {},
                    ),
                  ),
                ],
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

  _onError(e) {
    print("_onError: '$e'.");
    setState(() {
      payResult = "Giao dịch thất bại";
    });
  }

  void _onEvent(event) {
    print("_onEvent: '$event'.");
    var res = Map<String, dynamic>.from(event);
    setState(() {
      if (res["errorCode"] == 1) {
        payResult = "Thanh toán thành công";
      } else if (res["errorCode"] == 4) {
        payResult = "User hủy thanh toán";
      } else {
        payResult = "Giao dịch thất bại";
      }
    });
  }
}
