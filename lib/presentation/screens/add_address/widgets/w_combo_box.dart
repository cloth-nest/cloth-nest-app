import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:flutter/material.dart';

class WComboBox extends StatelessWidget {
  final Function(dynamic)? callback;
  final List<dynamic> source;
  final dynamic value;

  const WComboBox({
    super.key,
    required this.callback,
    required this.source,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lineBasic,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PlaceEntity>(
          isExpanded: true,
          value: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w300,
              ),
          dropdownColor: Colors.white,
          items: source
              .map(
                (e) => DropdownMenuItem<PlaceEntity>(
                  value: e,
                  child: Text(
                    '${e.name}',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
              )
              .toList(),
          onChanged: callback,
        ),
      ),
    );
  }
}
