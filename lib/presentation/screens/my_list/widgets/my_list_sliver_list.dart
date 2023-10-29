import 'package:ecommerce/presentation/screens/my_list/widgets/item_my_list.dart';
import 'package:flutter/material.dart';

class MyListSliverList extends StatelessWidget {
  const MyListSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return const ItemMyList();
        },
        childCount: 2,
      ),
    );
  }
}
