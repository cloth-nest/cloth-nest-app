import 'dart:async';

import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/cupertino.dart';

class ButtonSwitch extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const ButtonSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      trackColor: AppColors.trackSwitch.withOpacity(0.16),
      activeColor: AppColors.skyPerfectBlue,
      onChanged: onChanged,
    );
  }
}

class Toggle extends StatefulWidget {
  final bool isActivated;
  final int delay;
  final Function() onTrigger;

  const Toggle({
    Key? key,
    this.delay = 300,
    this.isActivated = false,
    required this.onTrigger,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ToggleState();
  }
}

class _ToggleState extends State<Toggle> {
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: widget.isActivated,
      trackColor: AppColors.trackSwitch.withOpacity(0.16),
      activeColor: AppColors.skyPerfectBlue,
      onChanged: (_) {
        if (_debounce?.isActive ?? false) {
          _debounce!.cancel();
        }

        _debounce = Timer(
          Duration(milliseconds: widget.delay),
          () {
            widget.onTrigger();
          },
        );
      },
    );
  }
}
