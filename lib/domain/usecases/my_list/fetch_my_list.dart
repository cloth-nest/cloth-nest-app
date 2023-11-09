import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';

abstract class FetchMyList {
  Future<List<MyListEntity>> call();
}
