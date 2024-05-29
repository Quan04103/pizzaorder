import 'package:flutter/material.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
        SizedBox(width: 4), // Khoảng cách từ lề bên trái
        CategoryCard(),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Image.asset(
        'assets/pizza.jpg',
        width: 90,
        height: 90,
      ),
    );
  }
}
