import 'package:flutter/material.dart';

class WVericalListReviews extends StatelessWidget {
  const WVericalListReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          'No data',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
