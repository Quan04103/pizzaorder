class CategoryModel {
  final String? id;
  final String? nameCategory;
  final String? image;

  const CategoryModel({
    this.id,
    this.nameCategory,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nameCategory': nameCategory,
      'image': image,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['_id'] as String?,
      nameCategory: map['nameCategory'] as String?,
      image: map['image'] as String?,
    );
  }
}
