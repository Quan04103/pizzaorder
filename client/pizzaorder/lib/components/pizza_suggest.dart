import 'package:flutter/material.dart';

class PizzaSuggest extends StatelessWidget {
  final List<Map<String, dynamic>> pizzaList = [
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
    {
      'name': 'Pizza Rau Củ Nướng Phô Mai',
      'rating': 4.3,
      'description':
          'Thanh Đạm Nhưng Cuốn Hút Từ Sự Hòa Quyện Giữa Cà Chua Beef, Cà Tím, Bí Ngòi, Xốt Cà Chua Và Phô Mai Béo Ngậy',
      'price': '79,000đ',
      'image': 'assets/pizza.jpg' // Replace with your image path
    },
  ];

  PizzaSuggest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: pizzaList.length,
//         itemBuilder: (context, index) {
//           final pizza = pizzaList[index];
//           return Card(
//             margin: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Container(
//                   width: 100, // Adjust this value to fit your needs
//                   height: 100, // Adjust this value to fit your needs
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(pizza['image']),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListTile(
//                     title: Text(pizza['name']),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.star, color: Colors.orange),
//                             const SizedBox(width: 4),
//                             Text('${pizza['rating']} • Pizza'),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(pizza['description']),
//                         const SizedBox(
//                             height: 8), // Space between description and price
//                         Row(
//                           children: [
//                             Expanded(
//                                 child:
//                                     Container()), // Pushes the price container to the right
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 4, horizontal: 12),
//                               decoration: BoxDecoration(
//                                 color: Colors.black,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 pizza['price'],
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Column(
        children: pizzaList.map((pizza) {
          return Card(
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              children: [
                Container(
                  width: 100, // Adjust this value to fit your needs
                  height: 100, // Adjust this value to fit your needs
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(pizza['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(pizza['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text('${pizza['rating']} • Pizza'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(pizza['description']),
                        const SizedBox(
                            height: 8), // Space between description and price
                        Row(
                          children: [
                            Expanded(
                                child:
                                    Container()), // Pushes the price container to the right
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                pizza['price'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
