import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';

abstract class AddMyList {
  Future<void> call({required MyListEntity entity});
}
