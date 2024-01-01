import 'package:ecommerce/domain/entities/service_type/service_type_entity.dart';

abstract class FetchServiceType {
  Future<List<ServiceTypeEntity>> call({required int toDistrict});
}
