import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:ecommerce/presentation/widgets/button/b_text_button.dart';
import 'package:flutter/material.dart';

class LoginGuestButton extends StatelessWidget {
  final VoidCallback onClick;
  const LoginGuestButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return BTextButton(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 23.5, vertical: 12),
      buttonName: 'Using without sign in',
      onClick: onClick,
      textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
            color:
                Theme.of(context).extension<ExtensionColors>()?.skyPerfectBlue!,
          ),
    );
  }
}
