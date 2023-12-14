import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class WListSearchLoading extends StatelessWidget {
  const WListSearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  bottom: 10,
                  top: 10,
                ),
                child: SizedBox(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(
                        height: 120,
                        width: 120,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(
                            height: 13,
                            width: 140,
                          ),
                          SizedBox(height: 5),
                          Skeleton(
                            height: 12,
                            width: 88,
                          ),
                          SizedBox(height: 3),
                          Skeleton(
                            height: 12,
                            width: 40,
                          ),
                          SizedBox(height: 3),
                          Skeleton(
                            height: 12,
                            width: 40,
                          ),
                          SizedBox(height: 20),
                          Skeleton(
                            height: 16,
                            width: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: 7,
          ),
        ),
      ],
    );
  }
}
