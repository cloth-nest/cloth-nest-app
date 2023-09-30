// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';
import 'package:hive/hive.dart';

import 'package:ecommerce/data/models/constant.dart';

part 'history_search_model.g.dart';

@HiveType(typeId: kHistorySearchTypeId)
class HistorySearchModel extends HiveObject {
  @HiveField(0)
  final List<String> keywords;

  HistorySearchModel({
    required this.keywords,
  });

  HistorySearchEntity toEntity() => HistorySearchEntity(
        keywords: keywords,
      );
}
