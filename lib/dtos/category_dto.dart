class CategoryDto {
  final String categoryId;
  final String name;

  const CategoryDto({
    required this.name,
    required this.categoryId,
  });

  CategoryDto.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        categoryId = json['categoryId'];
}
