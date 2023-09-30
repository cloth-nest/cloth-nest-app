import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';

abstract class FetchHistorySearch {
  Future<HistorySearchEntity?> call();
}
