class OrderModel {
  final String id;
  final String iduser;
  final List<Map<String, dynamic>> listorder;
  final double price;
  final DateTime dateadded;

  OrderModel({
    required this.id,
    required this.iduser,
    required this.listorder,
    required this.price,
    required this.dateadded,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      iduser: json['iduser'],
      listorder: List<Map<String, dynamic>>.from(json['listorder']),
      price: (json['price'] as num).toDouble(),
      dateadded: DateTime.parse(json['dateadded']),
    );
  }
}
