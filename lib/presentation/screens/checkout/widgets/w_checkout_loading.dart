import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class WCheckoutLoading extends StatelessWidget {
  const WCheckoutLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Skeleton(
              width: 50,
              height: 15,
            ),
            SizedBox(height: 10),
            Skeleton(
              height: 150,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Skeleton(
                  width: 50,
                  height: 15,
                ),
                Spacer(),
                Skeleton(
                  width: 50,
                  height: 15,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Skeleton(
                  width: 50,
                  height: 15,
                ),
                Spacer(),
                Skeleton(
                  width: 50,
                  height: 15,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Skeleton(
                  width: 50,
                  height: 15,
                ),
                Spacer(),
                Skeleton(
                  width: 50,
                  height: 15,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Skeleton(
                  width: 50,
                  height: 15,
                ),
                Spacer(),
                Skeleton(
                  width: 50,
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
