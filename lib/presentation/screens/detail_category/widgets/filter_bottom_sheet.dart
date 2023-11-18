import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterBottomSheet extends StatefulWidget {
  final String titleFilter;
  final List<String> contents;
  final List<Map<String, dynamic>> selectedValues;

  const FilterBottomSheet({
    super.key,
    required this.titleFilter,
    required this.contents,
    required this.selectedValues,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isActiveButton = false;

  bool checkActive() {
    if (widget.selectedValues.isNotEmpty) {
      return true;
    }

    for (final data in widget.selectedValues) {
      if (data['value'] == true) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    if (widget.selectedValues.isEmpty) {
      for (final data in widget.contents) {
        widget.selectedValues.add({'value': false, 'data': data});
      }
    } else {
      isActiveButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.92,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const Spacer(),
              Text(
                widget.titleFilter,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: SvgPicture.asset(
                  SvgPaths.iconClose,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              itemCount: widget.contents.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Checkbox(
                      value: widget.selectedValues[index]['value'] as bool,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedValues[index] = {
                            'data': widget.contents[index],
                            'value': value!
                          };
                          isActiveButton = checkActive();
                        });
                      },
                    ),
                    Text(
                      widget.contents[index],
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(height: 16.71 / 14),
                    ),
                  ],
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BRoundButton(
                isActive: isActiveButton,
                buttonName: 'Apply',
                onClick: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(isActiveButton ? widget.selectedValues : null);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
