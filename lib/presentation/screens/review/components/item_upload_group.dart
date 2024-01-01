import 'dart:io';

import 'package:ecommerce/presentation/screens/review/components/item_add_image.dart';
import 'package:ecommerce/presentation/screens/review/components/item_image.dart';
import 'package:ecommerce/presentation/screens/review/review_order_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemUploadGroup extends StatefulWidget {
  final List<File> images;

  const ItemUploadGroup({
    super.key,
    required this.images,
  });

  @override
  State<ItemUploadGroup> createState() => _ItemUploadGroupState();
}

class _ItemUploadGroupState extends State<ItemUploadGroup> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.images.isEmpty ? 1 : widget.images.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.images.length) {
          return ItemAddImage(
            index: index,
            callback: (images) {
              context.read<ReviewOrderPresenter>().setImages(images: images);
            },
          );
        }

        return ItemImage(
          index: index,
          callback: (i) {
            context.read<ReviewOrderPresenter>().removeAtIndex(index: index);
          },
          fileImage: widget.images[index],
        );
      },
    );
  }
}
