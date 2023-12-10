// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FetchProductParams extends Equatable {
  final int page;
  final int limit;
  final String? orderDirection;
  final List<String> colors;
  final List<String> sizes;
  final String? priceRange;
  final int idCategory;

  const FetchProductParams({
    required this.page,
    required this.limit,
    this.orderDirection,
    required this.colors,
    required this.sizes,
    this.priceRange,
    required this.idCategory,
  });

  @override
  List<Object?> get props => [
        page,
        limit,
        colors,
        sizes,
        idCategory,
      ];
}
