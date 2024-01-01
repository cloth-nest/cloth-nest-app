import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ItemAddImage extends StatelessWidget {
  final int index;
  final Function(List<File>) callback;

  const ItemAddImage({
    super.key,
    required this.callback,
    required this.index,
  });

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    List<File> files = [];

    if (result != null) {
      for (var path in result.paths) {
        File file = File(path!);
        files.add(file);
      }
      callback(files);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pickImage,
      child: SizedBox(
        width: 80,
        height: 80,
        child: DottedBorder(
          dashPattern: const [8, 5],
          color: AppColors.skyPerfectBlue,
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(0),
          child: const Center(
            child: Icon(
              Icons.camera_alt,
              color: AppColors.skyPerfectBlue,
            ),
          ),
        ),
      ),
    );
  }
}
