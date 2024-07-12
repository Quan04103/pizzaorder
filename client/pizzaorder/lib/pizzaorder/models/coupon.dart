class CouponModel {
  final String? id;
  final String? code;
  final String? description;
  final DateTime? expiryDate;
  final int? usageCount;
  final String? discount;
  final int? value;

  CouponModel({
    this.id,
    this.code,
    this.description,
    this.expiryDate,
    this.usageCount,
    this.discount,
    this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'description': description,
      'expiryDate': expiryDate?.toIso8601String(),
      'usageCount': usageCount,
      'discount': discount,
      'value': value,
    };
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['_id'] as String?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate'] as String) : null,
      usageCount: json['usageCount'] as int?,
      discount: json['discount'] as String?,
      value: json['value'] as int?,
    );
  }
}
