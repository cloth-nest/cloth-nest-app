import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class ItemProductLoading extends StatelessWidget {
  const ItemProductLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const horizontalPadding = 10.0;

    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: size.width / 2,
            height: size.width / 2,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: SizedBox(
              height: 14,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 9.0),
                    child: Skeleton(
                      height: 14,
                      width: 14,
                      borderRadius: 0,
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                Skeleton(width: 10, height: 10),
                Spacer(),
                Skeleton(width: 15, height: 10),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Skeleton(width: 50, height: 15),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Skeleton(width: 50, height: 15),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Skeleton(width: 50, height: 15),
          ),
        ],
      ),
    );
  }
}
