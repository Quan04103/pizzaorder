abstract class LoadProduct {}

class SearchProduct extends LoadProduct {
  final String query;
  SearchProduct(this.query);
}
