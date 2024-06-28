import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import 'package:pizzaorder/multiple_bloc_provider.dart';
import 'package:intl/intl.dart';

class ProductItemBagCart extends StatefulWidget {
  final OrderItem cartItems;

  const ProductItemBagCart({super.key, required this.cartItems});

  @override
  _ProductItemBagCartState createState() => _ProductItemBagCartState();
}

class _ProductItemBagCartState extends State<ProductItemBagCart> {
  late CartBloc cartBloc;

  get totalAllPrice => null;
  @override
  void initState() {
    super.initState();
    print('Init state _ProductItemBagCart');
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(const LoadList());
  }

  Future<void> increaseProductQuantity() async {
    cartBloc.add(IncreaseQuantityProduct(widget.cartItems));
    setState(() {});
  }

  Future<void> decreaseProductQuantity() async {
    if (widget.cartItems.quantity == 1) {
      cartBloc.add(RemoveProduct(widget.cartItems));
      setState(() {});
      return;
    } else {
      cartBloc.add(DecreaseQuantityProduct(widget.cartItems));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (context, state) {
        if (state.isUpdated) {
          bool productExists = state.cartItems
              .any((item) => item.idproduct == widget.cartItems.idproduct);

          if (!productExists) {
            return Container(); // Hoặc widget khác để hiển thị khi sản phẩm không tồn tại trong giỏ hàng
          } else {
            return buildProductItem();
          }
        } else {
          return Container(); // Xử lý trạng thái khác nếu cần
        }
      },
    );
  }

  Widget buildProductItem() {
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
                      onPressed: decreaseProductQuantity,
                    ),
                    Text(
                      widget.cartItems.quantity.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: increaseProductQuantity,
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
}
//   void _showDeleteConfirmationDialog(BuildContext context, OrderItem cartItem) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Delete'),
//           content: const Text(
//               'Are you sure you want to remove this product from the cart?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//             ),
//             TextButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 cartBloc.add(RemoveProduct(cartItem));
//                 Navigator.of(context).pop(true); // Close dialog and pass true
//                 setState(() {}); // Cập nhật UI ngay lập tức
//               },
//             ),
//           ],
//         );
//       },
//     ).then((value) {
//       if (value == true) {
//         // Update UI after dialog is closed (optional)
//       }
//     });
//   }
// }
