


import 'dart:convert';

import 'package:generalshop1/api/api_util.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:http/http.dart' as http;
class ProductApi{

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
  }
  
