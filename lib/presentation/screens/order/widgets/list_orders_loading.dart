import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class ListOrdersLoading extends StatelessWidget {
  const ListOrdersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Skeleton(
                    width: 166,
                    height: 35,
                  ),
                  Spacer(),
                  Skeleton(
                    width: 132,
                    height: 22,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Skeleton(
                width: 132,
                height: 22,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(
                          width: 132,
                          height: 22,
                        ),
                        SizedBox(height: 5),
                        Skeleton(
                          width: 132,
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: 5,
    );
  }
}
