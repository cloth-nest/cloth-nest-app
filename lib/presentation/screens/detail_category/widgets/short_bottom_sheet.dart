import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/detail_category/widgets/popup_menu.dart';
import 'package:flutter/material.dart';

class SortBottomSheet extends StatefulWidget {
  final String currentValue;

  const SortBottomSheet({
    super.key,
    required this.currentValue,
  });

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  final List<String> values = [
    'Created descending',
    'Price ascending',
    'Price descending'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.only(top: 5),
      child: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(60, 60, 67, .3),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(height: 11),
              Text(
                'Sort',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              PopupMenu(
                values: values,
                initValue: widget.currentValue,
                callback: (value) {
                  Navigator.of(context).pop(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
