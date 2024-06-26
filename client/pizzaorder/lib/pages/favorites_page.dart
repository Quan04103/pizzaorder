import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/favorite/favorite_state.dart';
import '../components/pizza_card.dart';
import 'package:go_router/go_router.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onPressGoBackHome() {
      final router = GoRouter.of(context);
      router.go('/home');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            // Handle back action
            _onPressGoBackHome();
          },
        ),
        title: Text('Danh Sách Yêu Thích',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded || state is FavoritesUpdated) {
            final favorites = state is FavoritesLoaded
                ? state.favorites
                : (state as FavoritesUpdated).favorites;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final pizza = favorites[index];
                return PizzaCard(product: pizza);
              },
            );
          } else {
            return Center(child: Text('Không có sản phẩm yêu thích'));
          }
        },
      ),
    );
  }
}
// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     void _onPressGoBackHome() {
//       final router = GoRouter.of(context);
//       router.go('/home');
//     }

//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.green[50],
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               // Handle back action
//               _onPressGoBackHome();
//             },
//           ),
//           title: const Text(
//             'Yêu thích',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.red,
//         ),
//         // body: BlocBuilder<FavoriteBloc, FavoriteState>(
//         //   builder: (context, state) {
//         //     if (state is FavoritesLoading) {
//         //       return CircularProgressIndicator();
//         //     } else if (state is FavoritesLoaded) {
//         //       return ListView.builder(
//         //         itemCount: state.favorites.length,
//         //         itemBuilder: (context, index) {
//         //           final product = state.favorites[index];
//         //           return ListTile(
//         //             title: Text('${product.name}'),
//         //             // Thêm các widget khác để hiển thị thông tin sản phẩm
//         //           );
//         //         },
//         //       );
//         //     } else {
//         //       // Xử lý trạng thái khác hoặc hiển thị thông báo lỗi
//         //       return Text('Có lỗi xảy ra');
//         //     }
//         //   },
//         // ),
//         body: SizedBox(
//           child: GridView.count(
//             crossAxisCount: 2,
//             // Thêm aspectRatio để điều chỉnh tỷ lệ khung hình của mỗi ô
//             // Ở đây, giả sử bạn muốn mỗi ô có chiều rộng gấp đôi chiều cao
//             // Bạn có thể thay đổi giá trị của aspectRatio để phù hợp với nhu cầu của bạn
//             childAspectRatio: 1 / 1.35,
//             // children: List.generate(10, (index) {
//             //   return const Center(child: PizzaCard());
//             // }),
//           ),
//         ),
//       ),
//     );
//   }
// }
