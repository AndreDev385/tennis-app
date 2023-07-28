class CategoryDto {
  final String categoryId;
  final String name;
  final String fullName;

  const CategoryDto({
    required this.categoryId,
    required this.name,
    required this.fullName,
  });

  CategoryDto.fromJson(Map<String, dynamic> json)
      : categoryId = json['categoryId'],
        name = json['name'],
        fullName = json['fullName'];
}
