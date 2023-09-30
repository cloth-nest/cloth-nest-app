import 'package:ecommerce/domain/entities/category/master_category_entity.dart';

abstract class FetchMasterCategory {
  Future<MasterCategoryEntity> call();
}
