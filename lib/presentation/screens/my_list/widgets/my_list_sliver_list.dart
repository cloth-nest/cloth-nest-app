import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/item_my_list.dart';
import 'package:flutter/material.dart';

class MyListSliverList extends StatelessWidget {
  final VoidCallback onTap;
  final List<MyListEntity> myListProducts;

  const MyListSliverList({
    super.key,
    required this.onTap,
    required this.myListProducts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ItemMyList(
            onTap: () {
              onTap.call();
            },
          );
        },
        childCount: 2,
      ),
    );
  }
}
