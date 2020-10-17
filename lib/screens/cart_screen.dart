import 'package:flutter/material.dart';
import 'package:generalshop1/api/cart_api.dart';
import 'package:generalshop1/cart/cart.dart';
import 'package:generalshop1/screens/utilities/helpers_widgets.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.monetization_on),
        onPressed: (){
          //TODO : go to check out screen
        },
      ),
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: (isLoading)? _showLoading : FutureBuilder(
        future: cartApi.fetchCart(),
        builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {

                return Text('error');
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.cartItems.length,
                    itemBuilder: (BuildContext context, int position) {
                      return ListTile(
                        title: Text(snapshot.data.cartItems[position].product.product_title),
                        trailing:Text(snapshot.data.cartItems[position].qty.toString()) ,
                      );
                    },
                  );
                } else {
                  return Text('no data');
                }
              }
              break;
            default:
              return Container();
              break;
          }

          return Container();
        },
      ),
    );
  }


  Widget _showLoading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

//  Widget _drawProductRow(CartItem cartItem) {
//    return Padding(
//      padding: const EdgeInsets.all(16.0),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Flexible(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Container(
//                  width: 100,
//                  height: 100,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: NetworkImage(cartItem.product.featuredImage()),
//                    ),
//                  ),
//                ),
//                Text(cartItem.product.product_title),
//              ],
//            ),
//          ),
//          Row(
//            children: <Widget>[
//              IconButton(
//                  icon: Icon(Icons.remove),
//                  onPressed: () async {
//                    setState(() {
//                      isLoading = true;
//                    });
////                    await cartApi
////                        .removeProductFromCart(cartItem.product.product_id);
//                    setState(() {
//                      isLoading = false;
//                    });
//                  }),
//              Text(cartItem.qty.toString()),
//              IconButton(
//                  icon: Icon(Icons.add),
//                  onPressed: () async {
//                    setState(() {
//                      isLoading = true;
//                    });
//                    await cartApi.addProductToCart(cartItem.product.product_id);
//                    setState(() {
//                      isLoading = false;
//                    });
//                  }),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
}
