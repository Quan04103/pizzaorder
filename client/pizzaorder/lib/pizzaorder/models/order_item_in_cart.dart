import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class OrderItem extends Equatable {
  final String idproduct;
  //them ten gia
  final String name;
  int quantity;
  int price;
  String image;
  OrderItem({
    required this.idproduct,
    required this.quantity,
      //
     required this.name,
     required this.price,
     required this.image,
  });
//tinh gia 
int get totalPrice => price * quantity;
  @override
  List<Object> get props => [idproduct, quantity, name , price ];

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      idproduct: json['idproduct'] as String,
      quantity: json['quantity'] as int,
      //
      name: json['name'] as String,
      price : json['price'] as int,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idproduct': idproduct,
      'quantity': quantity,
      //
        'name': name,
        'price': price,
        'image': image,
    };
  }

  OrderItem copyWith({
    String? idproduct,
    int? quantity,
    String? name,
    //
    String? image,
    int? price,
  }) {
    return OrderItem(
      name: name ?? this.name,
      price: price ?? this.price,
      idproduct: idproduct ?? this.idproduct,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }
}
