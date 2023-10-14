import 'package:ecommerce/domain/entities/history_search/history_search_entity.dart';

abstract class SaveHistorySearch {
  Future<void> call(HistorySearchEntity entity);
}
