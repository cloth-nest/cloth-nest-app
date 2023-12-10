import 'package:ecommerce/presentation/widgets/skeleton.dart';
import 'package:flutter/widgets.dart';

class WDetailProductLoading extends StatelessWidget {
  const WDetailProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const double paddingLeft = 20;

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(
          height: 300,
        ),
        SizedBox(height: 20),
        Skeleton(
          width: 300,
          height: 20,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 10),
        Skeleton(
          width: 300,
          height: 15,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingLeft,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Skeleton(
                  height: 50,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Skeleton(
                  height: 50,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Skeleton(
                  height: 50,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Skeleton(
          width: 300,
          height: 13,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 5),
        Skeleton(
          width: 300,
          height: 13,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 5),
        Skeleton(
          width: 300,
          height: 13,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 5),
        Skeleton(
          width: 300,
          height: 13,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 5),
        Skeleton(
          width: 300,
          height: 13,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 5),
        Skeleton(
          width: 300,
          height: 13,
          leftPadding: paddingLeft,
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Skeleton(
                height: 30,
                width: 120,
              ),
              SizedBox(width: 10),
              Skeleton(
                height: 30,
                width: 120,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                height: 100,
                width: 100,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Skeleton(
                    width: 300,
                    height: 13,
                  ),
                  SizedBox(height: 5),
                  Skeleton(
                    width: 300,
                    height: 13,
                  ),
                ],
              ))
            ],
          ),
        )
      ],
    );
  }
}
