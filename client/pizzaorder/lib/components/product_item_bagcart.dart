import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String? name;
  final String? imgs;
  final String? price;
  final int quanty;

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const ProductItem({
    Key? key,
    this.name,
    this.imgs,
    this.price,
    required this.quanty,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        border: Border.all(color: const Color(0xFF000000)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (imgs != null)
              Image.asset(
                imgs!,
                width: 100,
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (name != null)
                    Text(
                      name!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  const SizedBox(height: 5),
                  // box quanty
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: onDecrease,
                        ),                     
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: onIncrease,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (price != null)
              Text(
                price!,
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}
