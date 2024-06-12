import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String idproduct;
  int quantity;

  OrderItem({
    required this.idproduct,
    required this.quantity,
  });
  @override
  List<Object> get props => [idproduct, quantity];

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      idproduct: json['idproduct'] as String,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idproduct': idproduct,
      'quantity': quantity,
    };
  }

  OrderItem copyWith({
    String? idproduct,
    int? quantity,
  }) {
    return OrderItem(
      idproduct: idproduct ?? this.idproduct,
      quantity: quantity ?? this.quantity,
    );
  }
}
