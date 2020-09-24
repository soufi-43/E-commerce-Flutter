import 'dart:async';

import 'package:generalshop1/contracts/contracts.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:generalshop1/api/products_api.dart';

class HomeProductBloc implements Disposable {
  ProductsApi productsApi;

  List<Product> products;

  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();
  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  Stream<List<Product>> get productsStream => _productsController.stream;

  StreamSink<int> get fetchProducts => _categoryController.sink;

  Stream<int> get category => _categoryController.stream;

  int categoryID;

  HomeProductBloc() {
    productsApi = ProductsApi();
    products = [];
    _productsController.add(this.products);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoriesFromApi);
  }

  Future<void> _fetchCategoriesFromApi(int category) async {
    this.products = await productsApi.fetchProductsByCategory(category, 1);
    _productsController.add(products);
    print(products[0].product_id);
  }

  @override
  void dispose() {
    _productsController.close();
    _categoryController.close();
  }
}
