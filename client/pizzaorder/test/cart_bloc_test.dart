// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
// import 'package:pizzaorder/pizzaorder/services/order_service.dart';
// import 'package:pizzaorder/pizzaorder/bloc/cart/cart_bloc.dart';
// import 'package:pizzaorder/pizzaorder/bloc/cart/cart_event.dart';
// import 'package:pizzaorder/pizzaorder/bloc/cart/cart_state.dart';
// import 'package:pizzaorder/pizzaorder/models/order.dart';
// import 'package:pizzaorder/pizzaorder/models/order_item_in_cart.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// // flutter test test/cart_bloc_test.dart

// void main() async {
//   await dotenv.load();
//   group('CartBloc', () {
//     late CartBloc cartBloc;
//     OrderService orderService = OrderService();

//     setUp(() {
//       cartBloc = CartBloc();
//     });
//     tearDown(() {
//       cartBloc.close();
//     });
//     //Unit test add products to state
//     // blocTest<CartBloc, CartState>(
//     //   'emits [CartState.updated] when AddProducts is added',
//     //   build: () => cartBloc,
//     //   act: (bloc) => bloc.add(AddProducts(
//     //       [OrderItem(idproduct: '6648c85407ad9afaf88501e9', quantity: 2)])),
//     //   expect: () => [
//     //     CartState.updated(
//     //         [OrderItem(idproduct: '6648c85407ad9afaf88501e9', quantity: 2)])
//     //   ],
//     // );

//     blocTest<CartBloc, CartState>(
//       'should increase product quantity when IncreaseQuantityProduct is added',
//       build: () => cartBloc,
//       act: (bloc) async {
//         var product = OrderItem(idproduct: '1', quantity: 1);
//         bloc.add(AddProducts(product));
//         bloc.add(IncreaseQuantityProduct(product));
//       },
//       expect: () => [
//         CartState.updated([OrderItem(idproduct: '1', quantity: 2)]),
//       ],
//     );

//     blocTest<CartBloc, CartState>(
//       'should decrease product quantity when DecreaseQuantityProduct is added',
//       build: () => cartBloc,
//       act: (bloc) async {
//         var product = OrderItem(idproduct: '1', quantity: 2);
//         bloc.add(AddProducts(product));
//         bloc.add(DecreaseQuantityProduct(product));
//       },
//       expect: () => [
//         CartState.updated([OrderItem(idproduct: '1', quantity: 1)]),
//       ],
//     );
//     blocTest<CartBloc, CartState>(
//       'should remove product when RemoveProduct is added',
//       build: () => cartBloc,
//       act: (bloc) async {
//         var product = OrderItem(idproduct: '1', quantity: 2);
//         bloc.add(AddProducts(product));
//         bloc.add(RemoveProduct(product));
//       },
//       expect: () => [
//         CartState.updated(const []),
//       ],
//     );
//   });
// }
