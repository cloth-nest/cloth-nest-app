import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WReviews extends StatelessWidget {
  final double rating;
  final int numReviews;

  const WReviews({
    super.key,
    required this.rating,
    required this.numReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.only(right: 4.0),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Color(0xFFFFB930),
          ),
          itemSize: 20.0,
        ),
        Text(
          '(${numReviews.toString()})',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 12,
                height: 21 / 12,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
