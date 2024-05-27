import 'package:flutter/material.dart';
import 'package:pizzaorder/components/banner.dart';
import 'package:pizzaorder/components/product-card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 70,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 88, 6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/menu-burger.png',
                      width: 30,
                    ),
                    const Icon(
                      Icons.favorite_border,
                      size: 35,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: SearchBar(
                  hintText: 'Tìm kiếm....',
                  autoFocus: true,
                ),
              ),
              const BannerCard(),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Categories'),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('view all'),
                  ),
                ],
              ),
              //const ProductCard(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Newest'),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('view all'),
                  ),
                ],
              ),
              const ProductCard(),
            ],
          ),
        ),
      ),
    );
  }
}
