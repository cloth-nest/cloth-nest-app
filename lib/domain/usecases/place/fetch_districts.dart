import 'package:ecommerce/domain/entities/place/place_entity.dart';

abstract class FetchDistricts {
  Future<List<PlaceEntity>> call({required int code});
}
