import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SearchDetailScreen extends StatelessWidget {
  final String keyword;

  const SearchDetailScreen({
    super.key,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (context.canPopBeamLocation) {
              context.popBeamLocation();
            }
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Text('This is $keyword'),
      ),
    );
  }
}
