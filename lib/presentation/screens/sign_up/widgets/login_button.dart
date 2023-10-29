import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onClick;

  const LoginButton({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .extension<ExtensionColors>()
                        ?.outlineButtonTextColor,
                  ),
              text: 'Already have an account ? '),
          TextSpan(
            text: 'Login',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context)
                      .extension<ExtensionColors>()
                      ?.skyPerfectBlue,
                ),
            recognizer: TapGestureRecognizer()..onTap = onClick,
          ),
        ],
      ),
    );
  }
}
