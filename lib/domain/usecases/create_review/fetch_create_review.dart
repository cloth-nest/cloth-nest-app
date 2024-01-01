import 'dart:io';

abstract class FetchCreateReview {
  Future<void> call({
    required int idProduct,
    required String reviewContent,
    required double rating,
    required List<File> files,
  });
}
