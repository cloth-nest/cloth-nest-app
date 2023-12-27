import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class OrderDetailLoading extends StatelessWidget {
  const OrderDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skeleton(
              height: 35,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Skeleton(
                    width: 100,
                    height: 22,
                  ),
                  const SizedBox(height: 5),
                  const Skeleton(
                    width: 120,
                    height: 22,
                  ),
                  const SizedBox(height: 5),
                  const Skeleton(
                    width: 120,
                    height: 22,
                  ),
                  const SizedBox(height: 5),
                  const Skeleton(
                    width: 120,
                    height: 22,
                  ),
                  const SizedBox(height: 15),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Skeleton(
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  Skeleton(
                                    width: 120,
                                    height: 22,
                                  ),
                                  SizedBox(height: 2),
                                  Skeleton(
                                    width: 120,
                                    height: 22,
                                  ),
                                  SizedBox(height: 2),
                                  Skeleton(
                                    width: 120,
                                    height: 22,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: 2,
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                      Spacer(),
                      Skeleton(
                        width: 100,
                        height: 22,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
