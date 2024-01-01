import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/domain/entities/review/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:intl/intl.dart';

class ItemReview extends StatelessWidget {
  final ReviewEntity comment;

  const ItemReview({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comment.avatar == null
              ? Image.asset(
                  'assets/images/default_avatar.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                )
              : Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(comment.avatar!),
                    ),
                  ),
                ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${comment.firstName} ${comment.lastName}',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 15,
                      ),
                ),
                Text(
                  comment.content,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 5.0),
                if (comment.images.isNotEmpty)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...comment.images.map(
                        (image) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            width: 60,
                            height: 60,
                            memCacheWidth: 60,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: AppColors.textGray666,
                              );
                            },
                            placeholder: (context, url) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: AppColors.textGray666,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(comment.createdAt)),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 12),
                ),
                RatingBar.builder(
                  initialRating: comment.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xFFFFB930),
                  ),
                  onRatingUpdate: (value) {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
