import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/generated/locale_keys.g.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({Key? key, this.height = 110, required this.onTap})
      : super(key: key);
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BRoundButton(
      minimumSize: const Size(200, 45),
      maximumSize: const Size(200, 45),
      contentPadding: const EdgeInsets.symmetric(horizontal: 55, vertical: 11),
      buttonName: LocaleKeys.loginButtonText.tr(),
      customTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 15, color: AppColors.white, fontWeight: FontWeight.w600),
      onClick: onTap,
    );
  }
}
