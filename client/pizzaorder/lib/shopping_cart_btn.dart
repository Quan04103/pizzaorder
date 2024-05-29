import 'package:flutter/material.dart';

class ShoppingCartButton extends StatelessWidget {
  final VoidCallback onPressed;

  ShoppingCartButton(
      {required this.onPressed}); // Đảm bảo tham số onPressed là bắt buộc

  @override
  Widget build(BuildContext context) {
    return ClipRRect(    
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(
            Icons.shopping_cart_sharp,
            color: Colors.orange,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
