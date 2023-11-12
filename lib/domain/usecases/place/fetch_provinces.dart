import 'package:ecommerce/domain/entities/place/place_entity.dart';

abstract class FetchProvinces {
  Future<List<PlaceEntity>> call();
}
