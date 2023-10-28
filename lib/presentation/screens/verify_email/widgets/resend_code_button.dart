import 'dart:async';

import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/extensions/theme_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResendCodeButton extends StatefulWidget {
  final VoidCallback onClick;
  const ResendCodeButton({
    super.key,
    required this.onClick,
  });

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  late Timer _timer;
  final int expireTime = 180;
  late int _start;

  @override
  void initState() {
    super.initState();
    _start = expireTime;
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = expireTime;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
              text: 'You don\'t receive an code? '),
          TextSpan(
            text: 'Resend',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: _start == expireTime
                      ? AppColors.skyPerfectBlue
                      : Theme.of(context)
                          .extension<ExtensionColors>()
                          ?.outlineButtonTextColor,
                  fontWeight: FontWeight.w500,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (_start == expireTime) {
                  startTimer();
                  widget.onClick();
                }
              },
          ),
          TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
              text: ' (${_start}s)'),
        ],
      ),
    );
  }
}
