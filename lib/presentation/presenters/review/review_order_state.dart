// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class ReviewOrderState {
  final bool isLoading;
  final String review;
  final double rating;
  final List<File> images;

  ReviewOrderState({
    required this.isLoading,
    required this.review,
    required this.rating,
    required this.images,
  });

  factory ReviewOrderState.initial() => ReviewOrderState(
        isLoading: false,
        review: '',
        rating: 0,
        images: [],
      );

  ReviewOrderState copyWith({
    bool? isLoading,
    String? review,
    double? rating,
    List<File>? images,
  }) {
    return ReviewOrderState(
      isLoading: isLoading ?? this.isLoading,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      images: images ?? this.images,
    );
  }
}
