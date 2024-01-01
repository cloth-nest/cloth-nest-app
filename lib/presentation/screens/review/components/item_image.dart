import 'dart:io';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final int? index;
  final Function(int)? callback;
  final File fileImage;

  removeImage() {
    if (index == null) {
      callback!(0);
    } else {
      callback!(index!);
    }
  }

  const ItemImage({
    super.key,
    required this.fileImage,
    this.index,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            fileImage,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
        ),
        Positioned(
          right: 3,
          top: 3,
          child: GestureDetector(
            onTap: removeImage,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: AppColors.skyPerfectBlue,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
