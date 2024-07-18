import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzaorder/pages/detail_Product.dart';
import 'package:pizzaorder/pages/home_page.dart';
import 'package:pizzaorder/pizzaorder/bloc/search_product/search_bloc.dart';
import 'package:pizzaorder/pizzaorder/models/product.dart';
import 'package:pizzaorder/pizzaorder/services/search_service.dart';
import 'package:pizzaorder/pizzaorder/bloc/search_product/search_event.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc searchProductBloc;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchProductBloc = SearchBloc(productService: SearchService());
  }

  void search(String searchQuery) {
    if (searchQuery.isEmpty) {
      searchProductBloc.productController.sink.add([]);
    } else {
      searchProductBloc.add(SearchProduct(searchQuery));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      }),
                  Expanded(
                    child: CupertinoSearchTextField(
                      placeholder: "Bạn muốn ăn gì không?",
                      autofocus: true,
                      prefixInsets: const EdgeInsets.all(14),
                      suffixInsets: const EdgeInsets.all(14),
                      backgroundColor: Colors.grey[350],
                      borderRadius: BorderRadius.circular(20),
                      onChanged: (text) => search(text),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 30,
            ),
            Expanded(
              child: productsWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget productsWidget() {
    return StreamBuilder(
      stream: searchProductBloc.productController.stream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: snapshot.data?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
              color: Colors.grey,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(snapshot.data![index].name ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PizzaDetails(product: snapshot.data![index]),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchProductBloc.close();
    super.dispose();
  }
}
