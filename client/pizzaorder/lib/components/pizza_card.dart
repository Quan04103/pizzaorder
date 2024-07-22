import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_state.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import '../pizzaorder/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PizzaCard extends StatefulWidget {
  final ProductModel product;
  const PizzaCard({super.key, required this.product});

  @override
  _PizzaCardState createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> {
  late bool isFavorite;
  late OrderItem orderItem = OrderItem(
    idproduct: widget.product.id ?? '',
    quantity: 1,
    name: widget.product.name ?? '',
    price: widget.product.price ?? 0,
    image: widget.product.image ?? '',
  );
  @override
  void initState() {
    super.initState();
    isFavorite = context.read<FavoriteBloc>().isFavorite(widget.product);
  }

  void _onPressIconFavorite() {
    if (isFavorite) {
      BlocProvider.of<FavoriteBloc>(context)
          .add(RemoveFavorite(widget.product));
    } else {
      BlocProvider.of<FavoriteBloc>(context).add(AddFavorite(widget.product));
    }
  }

  void _onProductPressed(ProductModel product) {
    final router = GoRouter.of(context);
    router.go('/detail', extra: product);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoritesUpdated) {
          isFavorite = state.favorites.contains(widget.product);
        }
        return GestureDetector(
          onTap: () {
            _onProductPressed(widget.product);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              elevation: 10,
              child: SizedBox(
                width: 170,
                height: 260,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 110,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Your widget tree
                    Positioned(
                      top: 30, // Điều chỉnh giá trị này để ảnh nổi lên
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image(
                            image: NetworkImage(widget.product.image ?? ''),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 15,
                      // child: GestureDetector(
                      //   onTap: _onPressIconFavorite,
                      //   child: Icon(
                      //     Icons.favorite,
                      //     color: isFavorite ? Colors.red : Colors.grey,
                      //   ),
                      // ),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            _onPressIconFavorite();
                            setState(() {
                              isFavorite =
                                  !isFavorite; // Đảo ngược trạng thái của trái tim
                              // Thêm logic xử lý nếu cần
                            });
                          },
                        ),
                      ),
                    ),
                    // Other Positioned Widgets
                    Positioned(
                      top: 155,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            //widget.product.name ?? '',
                            widget.product.name!.length > 15
                                ? "${widget.product.name!.substring(0, 15)}..."
                                : widget.product.name ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 45, // Điều chỉnh khoảng cách từ dưới lên
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            //widget.product.description ?? '',
                            widget.product.description != null &&
                                    widget.product.description!.length > 40
                                ? "${widget.product.description!.substring(0, 40)}..."
                                : widget.product.description ?? '',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.left, // Căn giữa dòng chữ
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10, // Điều chỉnh khoảng cách từ dưới lên
                      left: 15,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.product.price != null
                              ? '${NumberFormat("#,##0", "vi_VN").format(widget.product.price)} VND'
                              : 'N/A',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left, // Căn giữa dòng chữ
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      height: 45,
                      width: 45,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                        ),
                        child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(AddProducts(orderItem));
                              // Add your onPressed code here!
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Auto close after 1 second
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return const AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Use min size for the column
                                      children: <Widget>[
                                        Icon(
                                          Icons.check, // Check icon
                                          color: Colors.green, // Icon color
                                          size: 50, // Icon size
                                        ),
                                        Text(
                                          'Thêm vào giỏ hàng thành công',
                                          textAlign: TextAlign
                                              .center, // Make text align to center
                                          style: TextStyle(
                                            color: Colors.blue, // Text color
                                            fontWeight:
                                                FontWeight.bold, // Text weight
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
