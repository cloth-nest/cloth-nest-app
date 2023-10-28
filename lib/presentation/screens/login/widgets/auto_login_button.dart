import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:ecommerce/presentation/widgets/button/b_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AutoLoginButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onClick;

  const AutoLoginButton(
      {super.key, required this.iconPath, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return BTextButton(
      contentPadding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
      buttonName: LocaleKeys.autoLoginButtonText.tr(),
      onClick: onClick,
      textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context)
                .extension<ExtensionColors>()
                ?.outlineButtonTextColor!,
          ),
      prefixIcon: SvgPicture.asset(
        iconPath,
      ),
    );
  }
}
