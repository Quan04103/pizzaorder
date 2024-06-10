import 'package:flutter/foundation.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> orderItems;
  final double price;
  final DateTime dateAdded;

  OrderModel({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.price,
    required this.dateAdded,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      orderItems: (json['orderItems'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      price: json['price'] as double? ?? 0,
      dateAdded: json['dateAdded'] != null
          ? DateTime.parse(json['dateAdded'] as String)
          : DateTime.now(),
    );
  }
}
