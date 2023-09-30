// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/history_search/history_search_model.dart';
import 'package:equatable/equatable.dart';

class HistorySearchEntity extends Equatable {
  final List<String> keywords;

  const HistorySearchEntity({
    required this.keywords,
  });

  HistorySearchModel toModel() => HistorySearchModel(
        keywords: keywords,
      );

  factory HistorySearchEntity.initial() => const HistorySearchEntity(
        keywords: [],
      );

  @override
  List<Object?> get props => [keywords];
}
