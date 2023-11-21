class CategoryEntity {
  final int id;
  final String name;
  final String? categoryThumbUrl;
  final List<CategoryEntity> subCategory;

  CategoryEntity(
      {required this.id,
      required this.name,
      required this.subCategory,
      this.categoryThumbUrl});
}
