import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/account/widgets/notification_dot.dart';
import 'package:flutter/material.dart';

class ItemAccount extends StatelessWidget {
  final String content;
  final Widget trailing;
  final bool? hasInformation;
  final bool? hasBorder;
  final bool? hasNotificationDot;
  final VoidCallback? onTapIconQuestion;
  final double paddingRight;

  const ItemAccount({
    super.key,
    required this.content,
    required this.trailing,
    this.hasInformation = false,
    this.hasBorder = true,
    this.hasNotificationDot = false,
    this.onTapIconQuestion,
    this.paddingRight = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: hasBorder!
            ? const Border(
                bottom: BorderSide(
                  color: AppColors.lineBasic,
                ),
              )
            : null,
      ),
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: paddingRight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      content,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14,
                            height: 21 / 14,
                          ),
                    ),
                  ),
                  if (hasNotificationDot!) const NotificationDot()
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
