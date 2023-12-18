import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class CartSliverListLoading extends StatelessWidget {
  const CartSliverListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              right: 20,
              left: 20,
            ),
            child: Row(
              children: [
                Skeleton(
                  height: 100,
                  width: 100,
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(
                        height: 13,
                        width: 140,
                      ),
                      Skeleton(
                        height: 13,
                        width: 70,
                      ),
                      SizedBox(height: 3),
                      Skeleton(
                        height: 12,
                        width: 88,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Skeleton(
                      height: 20,
                      width: 20,
                      borderRadius: 100,
                    ),
                    SizedBox(width: 10),
                    Skeleton(
                      width: 8,
                      height: 8,
                    ),
                    SizedBox(width: 10),
                    Skeleton(
                      height: 20,
                      width: 20,
                      borderRadius: 100,
                    )
                  ],
                )
              ],
            ),
          );
        },
        childCount: 7,
      ),
    );
  }
}
