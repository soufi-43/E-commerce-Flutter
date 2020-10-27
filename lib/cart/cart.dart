import 'dart:convert';

import 'package:generalshop1/product/Product.dart';
import 'package:generalshop1/product/product_category.dart';

class CartItem {
  Product product;

  double qty;

  CartItem( this.product,this.qty);

  CartItem.fromJson(Map<String, dynamic> jsonObject) {
   this.product = Product.fromJson(jsonObject['product']);
   //print(this.product);

    this.qty = double.tryParse(jsonObject['qty']);
  }
}

class Cart {
  List<CartItem> cartItems;

  int id;

  double total;

  Cart(this.cartItems, this.id, this.total);

  Cart.fromJson(Map<String, dynamic> jsonObject) {
    cartItems = [];
    var items = jsonObject['cart_items'];
    //print(items);
    for (var item in items) {
      //cartItems.add(CartItem.fromJson(item));
    cartItems.add(CartItem.fromJson(item));
      //print(item['product']);
      //print('=============================================================/n ==============================');
    }
    this.id = jsonObject['id'];
    this.total = jsonObject['total'];
  }
}
