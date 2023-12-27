import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/double_extension.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/presentation/screens/order/widgets/w_item_tag_order.dart';
import 'package:flutter/material.dart';

class WItemOrder extends StatelessWidget {
  final OrderEntity order;
  const WItemOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WItemTagOrder(status: order.status),
              const Spacer(),
              Text(
                DateFormat('dd/MM/yyyy HH:MM').format(
                  DateTime.parse(order.createdAt).toLocal(),
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textGray999,
                    ),
              )
            ],
          ),
          const SizedBox(height: 5),
          itemRow(context, key: 'Transaction ID', value: order.id.toString()),
          if (order.status == "DELIVERED") const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    itemRow(context, key: 'Deliver To', value: order.detail),
                    itemRow(context,
                        key: 'Total Payment', value: order.total.toMoney()),
                  ],
                ),
              ),
              // order.status == "DELIVERED"
              //     ? GestureDetector(
              //         onTap: () {
              //           Navigator.of(context).push(
              //             MaterialPageRoute(
              //               builder: (_) => ReviewOrderScreen(
              //                 order: order,
              //               ),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           padding: const EdgeInsets.symmetric(
              //             vertical: 10,
              //             horizontal: 10,
              //           ),
              //           decoration: BoxDecoration(
              //             color: AppColors.primary,
              //             borderRadius: BorderRadius.circular(9),
              //           ),
              //           child: Text(
              //             'Review',
              //             textAlign: TextAlign.center,
              //             style: AppStyles.semibold.copyWith(
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       )
              //     : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }

  Widget itemRow(BuildContext context,
      {required String key, required String value}) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$key: ',
          style: Theme.of(context).textTheme.headlineSmall,
          softWrap: true,
        ),
        const SizedBox(height: 5),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
