import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';

class ProductItemBagCart extends StatefulWidget {
  final OrderItem cartItems;

  const ProductItemBagCart({Key? key, required this.cartItems}) : super(key: key);

  @override
  _ProductItemBagCartState createState() => _ProductItemBagCartState();
  
}

class _ProductItemBagCartState extends State<ProductItemBagCart> {

    late CartBloc cartBloc;
    @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(LoadList());
  }
@override
Widget build(BuildContext context) {
  // Tìm sản phẩm hiện tại trong danh sách giỏ hàng từ trạng thái Bloc
  // var currentCartItem = cartBloc.state.cartItems.firstWhere(
  //   (item) => item.idproduct == widget.cartItems.idproduct,
  //   orElse: () => widget.cartItems,
  // );

  // Kiểm tra xem sản phẩm còn trong giỏ hàng không
  // if (cartBloc.state.isUpdated && widget.cartItems.quantity == 0) {
  //   return SizedBox.shrink(); // Trả về một widget trống
  // }

  return Container(
    margin: const EdgeInsets.all(7),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFF000000)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Image.network(
          widget.cartItems.image,
          width: 50,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cartItems.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (widget.cartItems.quantity <= 1) {
                        _showDeleteConfirmationDialog(context, widget.cartItems);
                      } else {
                        cartBloc.add(DecreaseQuantityProduct(widget.cartItems));
                        setState(() {});
                      }
                    },
                  ),
                  Text(
                    widget.cartItems.quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartBloc.add(IncreaseQuantityProduct(widget.cartItems));
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          '${widget.cartItems.totalPrice.toStringAsFixed(2)}đ',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}

void _showDeleteConfirmationDialog(BuildContext context, OrderItem cartItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to remove this product from the cart?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              cartBloc.add(RemoveProduct(cartItem));
              Navigator.of(context).pop(true); // Close dialog and pass true
              setState(() {}); // Cập nhật UI ngay lập tức
            },
          ),
        ],
      );
    },
  ).then((value) {
    if (value == true) {
      // Update UI after dialog is closed (optional)
    }
  });
}
}