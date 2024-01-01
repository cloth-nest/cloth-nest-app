// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReviewEntity {
  final List<String> images;
  final String content;
  final double rating;
  final String createdAt;
  final String lastName;
  final String firstName;
  final String? avatar;

  ReviewEntity({
    required this.images,
    required this.content,
    required this.rating,
    required this.createdAt,
    required this.lastName,
    required this.firstName,
    this.avatar,
  });
}
