


import 'dart:convert';

import 'package:generalshop1/api/api_util.dart';
import 'package:generalshop1/exceptions/exceptions.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:http/http.dart' as http;
class ProductsApi{

  Map<String,String> headers = {
    'Accept':'application/json',
  };
  
  
  Future<List<Product>> fetchProducts(int page) async{
    await checkInternet();
    

    
    String url = ApiUtl.PRODUCTS+'?page='+page.toString();

    http.Response response = await http.get(url, headers: headers);
    List<Product> products = [];

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        print(item);
        products.add(Product.fromJson(item));
      }
      return products;
    }
    return null;
  }

  Future<Product> fetchProduct(int product_id) async{
    await checkInternet();
    String url = ApiUtl.PRODUCT+product_id.toString();

    http.Response response = await http.get(url, headers: headers);

    if(response.statusCode==200){
      var body = jsonDecode(response.body);
      return Product.fromJson(body['data']);

    }
    return null;



  }



  Future<List<Product>> fetchProductsByCategory(int category, int page) async {
    await checkInternet();

    String url = ApiUtl.CATEGORY_PRODUCTS(category, page);

    http.Response response = await http.get(url, headers: headers);
    List<Product> products = [];
    switch (response.statusCode) {
      case 404:
        throw ResourceNotFound('products');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      case 200:
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          products.add(Product.fromJson(item));
        }
        return products;
        break;
      default  :
        return null ;
        break ;
    }

  }
  }
  
