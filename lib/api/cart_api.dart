import 'dart:convert';

import 'package:generalshop1/cart/cart.dart';
import 'package:generalshop1/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_util.dart';

class CartApi {


  Future<Cart> fetchCart() async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    print(apiToken);
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken,
    };
    String cartApi = ApiUtl.CART;
    http.Response response = await http.get(cartApi, headers: authHeaders);
    print(response.statusCode) ;

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        return Cart.fromJson(body);
        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }

//  Future<bool> removeProductFromCart(int productID) async{
//    await checkInternet();
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String apiToken = sharedPreferences.get('api_token');
//    String cartApi = ApiUtl.REMOVE_FROM_CART;
//    print(apiToken);
//
//    Map<String, String> authHeaders = {
//      'Accept': 'application/json',
//      'Authorization': 'Bearer ' + apiToken,
//    };
//
//    Map<String, dynamic> body = {
//      'product_id': productID.toString(),
//    };
//    http.Response response =
//    await http.post(cartApi, headers: authHeaders, body: body);
//    print(response.statusCode);
//    print(response.body);
//    switch (response.statusCode) {
//      case 200:
//      case 201:
//        return true;
//        break;
//      default:
//        throw ResourceNotFound('Cart');
//        break;
//    }
//  }
  Future<bool> addProductToCart(int productID) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    print('thiiisssssssss isss apii ttokkken' +apiToken);

    String cartApi = ApiUtl.CART;

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken,
    };

    Map<String, dynamic> body = {
      'product_id': productID.toString(),
      'qty': 1.toString(),
    };
    http.Response response =
    await http.post(cartApi, headers: authHeaders, body: body);
    print(response.statusCode);
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }

  }



