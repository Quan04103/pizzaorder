import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back action
          },
        ),
        title: const Text(
          'Lịch sử hoạt động',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: List.generate(10, (index) {
          return Column(
            children: [
              if (index == 0) const SizedBox(height: 40),
              const HistoryItem(
                image: 'assets/pizza.jpg',
                title: 'PIZZA HẢI SẢN...',
                price: '109.000 đ',
                date: '14 THG 4 2024, 19:01',
              ),
              const Divider(),
            ],
          );
        }),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String date;

  const HistoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 70,
        height: 70,
        child: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(date),
      trailing: Text(
        price,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
