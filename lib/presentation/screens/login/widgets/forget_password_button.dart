import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:ecommerce/presentation/widgets/button/b_text_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  final VoidCallback onClick;

  const ForgetPasswordButton({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return BTextButton(
      contentPadding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
      buttonName: LocaleKeys.forgetPasswordButtonText.tr(),
      onClick: onClick,
      textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color:
                Theme.of(context).extension<ExtensionColors>()?.skyPerfectBlue,
          ),
    );
  }
}
