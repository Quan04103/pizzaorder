class ProductModel {
  final String? id;
  final String? categoryId;
  final String? name;
  final String? description;
  final int? price;
  final String? image;
  final List<String>? more;
  final String? link;

  const ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.image,
    this.more,
    this.link,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as String?,
      categoryId: map['categoryId'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      price: map['price'] as int?,
      image: map['image'] as String?,
      more: (map['more'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      link: map['link'] as String?,
    );
  }
}
