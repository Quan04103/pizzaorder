import 'package:flutter/material.dart';
import 'package:pizzaorder/pizzaorder/models/order_history.dart';
import 'package:pizzaorder/pizzaorder/services/order_service_history.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<OrderModel>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = OrderService().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Lịch sử hoạt động',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          } else {
            return Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListView(
                children: snapshot.data!.map((order) {
                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      OrderSummary(
                        date: order.dateadded.toIso8601String(),
                        price: order.price,
                        items: order.listorder,
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double price;
  final String date;
  final List<Map<String, dynamic>> items;

  const OrderSummary({
    super.key,
    required this.price,
    required this.date,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the date string to a DateTime object
    DateTime dateTime = DateTime.parse(date);
    // Format the date
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    // Format the price with thousands separator and currency suffix
    String formattedPrice =
        '${NumberFormat('#,###', 'en_US').format(price)} VND';

    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          HistoryItem(
            items: items,
            date: formattedDate,
            totalPrice: price,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.attach_money, color: Colors.red),
                    const SizedBox(width: 4.0),
                    Text(
                      'Thành tiền: $formattedPrice',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final String date;

  const HistoryItem({
    super.key,
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Column(
          children: [
            ListTile(
              leading: SizedBox(
                width: 70,
                height: 70,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(item['image'] as String),
                ),
              ),
              title: Text(
                item['name'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: Text(
                'x${item['quantity']}',
                style: const TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 8.0), // Add spacing between products
          ],
        );
      }).toList(),
    );
  }
}
