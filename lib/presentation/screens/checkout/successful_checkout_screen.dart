import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:flutter/material.dart';

class SuccessfulCheckOutScreen extends StatelessWidget {
  const SuccessfulCheckOutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.skyPerfectBlue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -5,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          size: 35,
                          color: AppColors.skyPerfectBlue,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    SvgPaths.star,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Your order\nhas been successful 🎉',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Check your order status in ',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'My Order\n',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.white),
                    ),
                    const TextSpan(
                      text: 'about next steps information.',
                    ),
                  ],
                ),
              )
            ],
          ),
          _bottom(size, context),
        ],
      ),
    );
  }

  Widget _bottom(Size size, BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        height: size.height * 0.2,
        width: size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preparing your order',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 15,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your order will be prepared and will come soon',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 15,
                  ),
            ),
            const Spacer(),
            BRoundButton(
              buttonName: 'Track My Order',
              onClick: () {
                beamTo(context, path: 'orders');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
