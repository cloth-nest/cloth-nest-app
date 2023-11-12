import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

const List<String> languages = [
  'English',
  'Vietnamese',
];

class ButtonChooseLanguage extends StatelessWidget {
  const ButtonChooseLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog(context);
      },
      child: Selector<AccountPresenter, String>(
        builder: (context, language, _) => Text(
          language,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.skyPerfectBlue,
                fontSize: 14,
                height: 21 / 14,
              ),
        ),
        selector: (_, presenter) => presenter.settingAccount.language,
      ),
    );
  }

  void _showDialog(BuildContext context) async {
    final accountPresenter = context.read<AccountPresenter>();

    await showAlignedDialog(
      context: context,
      followerAnchor: Alignment.topRight,
      targetAnchor: Alignment.centerRight,
      barrierColor: Colors.transparent,
      offset: const Offset(0, -7),
      builder: (BuildContext context) {
        return PopupMenu(
          maxWidth: 180,
          values: languages,
          initValue: accountPresenter.settingAccount.language,
          callback: (value) {
            //accountPresenter.setTimeReceiveInformation(value);
          },
        );
      },
    );
  }
}

class PopupMenu extends StatelessWidget {
  final double maxWidth;
  final List<String> values;
  final String initValue;
  final Function(String)? callback;

  const PopupMenu({
    super.key,
    required this.maxWidth,
    required this.values,
    required this.initValue,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      constraints: BoxConstraints(maxWidth: maxWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
        color: AppColors.white,
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 16,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: values
            .map((e) => _buildPopupMenuItem(e, initValue, context))
            .toList(),
      ),
    );
  }

  Widget _buildPopupMenuItem(String e, String initValue, BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback!(e);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              e,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: e == initValue
                        ? AppColors.iconActive
                        : AppColors.textLightBasic,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    height: 19.6 / 14,
                  ),
            ),
            const Spacer(),
            e == initValue
                ? SvgPicture.asset(SvgPaths.iconSelect)
                : SvgPicture.asset(SvgPaths.iconUnselect),
          ],
        ),
      ),
    );
  }
}
