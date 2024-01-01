import 'dart:io';

import 'package:ecommerce/presentation/screens/review/components/item_upload_group.dart';
import 'package:ecommerce/presentation/screens/review/review_order_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:ecommerce/presentation/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ReviewOrderScreen extends StatefulWidget {
  final int idProduct;

  const ReviewOrderScreen({
    super.key,
    required this.idProduct,
  });

  @override
  State<ReviewOrderScreen> createState() => _ReviewOrderScreenState();
}

class _ReviewOrderScreenState extends State<ReviewOrderScreen> {
  final TextEditingController reviewController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late ReviewOrderPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<ReviewOrderPresenter>();
  }

  @override
  void dispose() {
    super.dispose();
    reviewController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(title: 'Review Order'),
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 20),
              _rating(context),
              const SizedBox(height: 10),
              _buildDivider(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Write your review',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(height: 16.71 / 14),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  height: 50,
                  child: NormalTextField(
                    controller: reviewController,
                    focusNode: focusNode,
                    placeHolder: 'Enter your review',
                    onChanged: (String? value) {
                      presenter.setReviewContent(review: value!.trim());
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildDivider(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Your images',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(height: 16.71 / 14),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Selector<ReviewOrderPresenter, List<File>>(
                  selector: (_, presenter) => presenter.images,
                  builder: (_, images, __) => ItemUploadGroup(
                    images: images,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BRoundButton(
                  buttonName: 'Review',
                  onClick: () {
                    presenter.review(idProduct: widget.idProduct);
                  },
                ),
              ),
            ],
          ),
          Selector<ReviewOrderPresenter, bool>(
            selector: (context, presenter) => presenter.isLoading,
            builder: (context, isLoading, _) {
              if (isLoading) {
                return Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 3,
      color: const Color(0xFFEEEEEE),
    );
  }

  Widget _rating(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'Quality of products',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(height: 16.71 / 14),
          ),
          const Spacer(),
          Selector<ReviewOrderPresenter, double>(
            selector: (_, presenter) => presenter.rating,
            builder: (_, rating, __) => RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.only(right: 5.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xFFFFB930),
              ),
              onRatingUpdate: (value) {
                presenter.setRate(rate: value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
