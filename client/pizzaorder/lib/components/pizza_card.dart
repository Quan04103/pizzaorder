// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
// import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
// import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';
// import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_bloc.dart';
// import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_event.dart';
// import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_state.dart';
// import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
// import '../pizzaorder/models/product.dart';

// class PizzaCard extends StatefulWidget {
//   final ProductModel product;
//   const PizzaCard({super.key, required this.product});

//   @override
//   _PizzaCardState createState() => _PizzaCardState();
// }

// class _PizzaCardState extends State<PizzaCard> {
//   bool isFavorite = false;
//   late OrderItem orderItem = OrderItem(
//     idproduct: widget.product.id ?? '',
//     quantity: 1,
//   );
//   _initFav() {
//     isFavorite = context.read<FavoriteBloc>().isFavorite(widget.product);
//   }

//   @override
//   void initState() {
//     super.initState();
//     isFavorite = context.read<FavoriteBloc>().isFavorite(widget.product);
//   }

//   late ProductModel item = widget.product;
//   // void _onPressIconFavorite() {
//   //   BlocProvider.of<FavoriteBloc>(context).add(AddFavorite(ProductModel as ProductModel));
//   //   setState(() {
//   //     isFavorite = !isFavorite;
//   //   });
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<FavoriteBloc, FavoriteState>(
//       listener: (context, state) {
//         if (state is FavoritesUpdated) {
//           bool isFavorite = state is FavoritesUpdated
//               ? state.favorites.contains(widget.product)
//               : false;
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Danh sách yêu thích đã được cập nhật')),
//           );
//         }
//       },
//       child: BlocBuilder<FavoriteBloc, FavoriteState>(
//         builder: (context, state) {
//           // Giả sử trạng thái FavoriteState có một danh sách các sản phẩm yêu thích
//           // bool isFavorite = state is FavoritesUpdated
//           //     ? state.favorites.contains(widget.product)
//           //     : false;

//           // setState() {
//           //   isFavorite =
//           //       context.read<FavoriteBloc>().isFavorite(widget.product);
//           // }

//           return Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30.0)),
//             elevation: 10,
//             child: SizedBox(
//               width: 170,
//               height: 260,
//               child: Stack(
//                 clipBehavior:
//                     Clip.none, // Sử dụng clipBehavior thay vì overflow
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         height: 110,
//                         decoration: const BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(30.0),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     top: 30, // Điều chỉnh giá trị này để ảnh nổi lên
//                     left: 0,
//                     right: 0,
//                     child: Center(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(40),
//                         child: Image(
//                           image: NetworkImage(widget.product.image ?? ''),
//                           width: 120,
//                           height: 120,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 20,
//                     right: 15,
//                     child: GestureDetector(
//                       onTap: () {
//                         if (isFavorite) {
//                           BlocProvider.of<FavoriteBloc>(context)
//                               .add(RemoveFavorite(widget.product));
//                         } else {
//                           BlocProvider.of<FavoriteBloc>(context)
//                               .add(AddFavorite(widget.product));
//                         }
//                       },
//                       child: Container(
//                         width: 38,
//                         height: 38,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white,
//                         ),
//                         child: BlocListener<FavoriteBloc, FavoriteState>(
//                           listener: (context, state) {
//                             if (state is FavoritesUpdated) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text(
//                                         'Danh sách yêu thích đã được cập nhật')),
//                               );
//                             }
//                           },
//                           child: Icon(
//                             Icons.favorite,
//                             color: isFavorite
//                                 ? Colors.red
//                                 : Colors
//                                     .grey, // Thay đổi màu sắc để phản ánh trạng thái không yêu thích rõ ràng hơn
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 155,
//                     left: 0,
//                     right: 0,
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           widget.product.name ?? '',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 45, // Điều chỉnh khoảng cách từ dưới lên
//                     left: 0,
//                     right: 0,
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           widget.product.description ?? '',
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: Colors.grey[600],
//                           ),
//                           textAlign: TextAlign.left, // Căn giữa dòng chữ
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Positioned(
//                     bottom: 10, // Điều chỉnh khoảng cách từ dưới lên
//                     left: 15,
//                     right: 0,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         '\$62',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.left, // Căn giữa dòng chữ
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     height: 45,
//                     width: 45,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.0),
//                           bottomRight: Radius.circular(30.0),
//                         ),
//                       ),
//                       child: IconButton(
//                           icon: const Icon(Icons.add, color: Colors.white),
//                           onPressed: () {
//                             context
//                                 .read<CartBloc>()
//                                 .add(AddProducts(orderItem));
//                             // Add your onPressed code here!
//                           }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _onPressIconFavorite() {
//     if (isFavorite) {
//       BlocProvider.of<FavoriteBloc>(context)
//           .add(RemoveFavorite(widget.product));
//     } else {
//       BlocProvider.of<FavoriteBloc>(context).add(AddFavorite(widget.product));
//     }
//     // Không cần setState ở đây vì BlocBuilder sẽ xử lý việc rebuild UI
//   }
// }

// class _AddButton extends StatelessWidget {
//   final ProductModel item;
//   const _AddButton({required this.item, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavoriteBloc, FavoriteState>(
//       builder: (context, state) {
//         var isInFavoritePage = false;
//         if (state is FavoritesUpdated) {
//           isInFavoritePage = state.favorites.contains(item);
//         }
//         return IconButton(
//             icon: isInFavoritePage
//                 ? Icon(Icons.favorite, color: Colors.red)
//                 : Icon(Icons.favorite_border),
//             onPressed: () {
//               if (isInFavoritePage) {
//                 context.read<FavoriteBloc>().add(RemoveFavorite(item));
//               } else {
//                 context.read<FavoriteBloc>().add(AddFavorite(item));
//               }
//             });
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_state.dart';
import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
import '../pizzaorder/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoritesUpdated) {
          isFavorite = state.favorites.contains(widget.product);
        }
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                        widget.product.name ?? '',
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
                        widget.product.description ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.left, // Căn giữa dòng chữ
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 10, // Điều chỉnh khoảng cách từ dưới lên
                  left: 15,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$62',
                      style: TextStyle(
                        fontSize: 18,
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
                          context.read<CartBloc>().add(AddProducts(orderItem));
                          // Add your onPressed code here!
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
