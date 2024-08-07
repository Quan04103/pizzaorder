import '../models/product.dart';
import '../services/product_service.dart';

//How to test this file by Quân
// D:\flutter\pizzaorder\client\pizzaorder\lib\pizzaorder\apiTest> dart run test.dart

void main() async {
  ProductService productService = ProductService();
  List<ProductModel> product =
      await productService.getProductByCategoryId('6646fc283146973b72ad5eb2');
  print('Received id: ${product.length}');
  for (var element in product) {
    print('Product id: ${element.id}');
    print('Product name: ${element.name}');
    print('Product price: ${element.price}');
  }
}
