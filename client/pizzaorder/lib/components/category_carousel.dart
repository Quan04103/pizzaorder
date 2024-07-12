import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizzaorder/pages/all_product_page.dart';
import 'package:pizzaorder/pages/product_category_page.dart';
import '../pizzaorder/models/category.dart';
import '../pizzaorder/services/category_service.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryService categoryService = CategoryService();

    return FutureBuilder<List<CategoryModel>>(
      future: categoryService.getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              CategoryModel category = snapshot.data![index];
              return CategoryCard(category: category);
            },
          );
        } else {
          return const Text('No categories found');
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllProductPage(
                categoryId: category.id ??
                    ''), // Giả sử category model của bạn có trường id
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/${category.nameCategory}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          // Text("${category.image}"),
        ],
      ),
    );
  }
}
