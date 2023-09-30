// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/category/master_category_entity.dart';

class ContentMasterState {
  final MasterCategoryEntity? masterCategoryEntity;

  ContentMasterState({
    required this.masterCategoryEntity,
  });

  ContentMasterState copyWith({
    MasterCategoryEntity? masterCategoryEntity,
  }) {
    return ContentMasterState(
      masterCategoryEntity: masterCategoryEntity ?? this.masterCategoryEntity,
    );
  }

  factory ContentMasterState.initial() {
    return ContentMasterState(masterCategoryEntity: null);
  }
}
