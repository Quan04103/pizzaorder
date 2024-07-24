import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'banner.dart';

List<Widget> banners = [
  // banner1(0xFFE6361D, 'images/image_banner1.png'),
  // banner1(0xFF292C7E, 'images/image_banner1.png'),
  // banner1(0xFF007358, 'images/image_banner1.png'),
  // banner1(0xFFFF7A00, 'images/image_banner1.png'),
  banner(0xFFE6361D, 'assets/pizzar7.png', '199,000'),
  banner(0xFF292C7E, 'assets/pizzar1.png', '169,000'),
  banner(0xFF007358, 'assets/pizzar6.png', '159,000'),
];

Widget slide() {
  return CarouselSlider(
      options: CarouselOptions(
        initialPage: 0,
        autoPlay: true,
        aspectRatio: 2,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
      items: banners);
}
