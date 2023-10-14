import 'dart:io' show Platform;
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String) onChanged;
  final void Function(String) onSubmitSearch;
  final TextEditingController searchController;
  final VoidCallback onClearButton;
  final bool isShowButton;
  final void Function(String) onPressedBtnSearch;

  const SearchTextField({
    Key? key,
    required this.onChanged,
    required this.searchController,
    required this.isShowButton,
    required this.onClearButton,
    required this.onSubmitSearch,
    required this.onPressedBtnSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.placeholderLightMode,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(100.0),
              onTap: () {
                onPressedBtnSearch(searchController.text);
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: SvgPicture.asset(
                  SvgPaths.iconSearchTransfer,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textGray666,
                    ),
                textAlignVertical: TextAlignVertical.center,
                controller: searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: LocaleKeys.searchInputText.tr(),
                  hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textGray666,
                      ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Platform.isIOS ? 7 : 8,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: onChanged,
                onSubmitted:
                    searchController.text != '' ? onSubmitSearch : null,
              ),
            ),
          ),
          if (isShowButton)
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(100.0),
                onTap: onClearButton,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    SvgPaths.iconClear,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
