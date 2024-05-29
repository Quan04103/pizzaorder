import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:pizzaorder/pizzaorder/services/product_service.dart';

//How to test this file by Quân
// D:\flutter\pizzaorder\client\pizzaorder\lib\pizzaorder\apiTest> dart run test.dart

void main() async {
  ProductService productService = ProductService('http://localhost:5000');
  List<ProductModel> product = await productService.getProduct();
  print('Received id: ${product.length}');
  for (var element in product) {
    print('Product id: ${element.id}');
    print('Product name: ${element.name}');
    print('Product price: ${element.price}');
  }
}
