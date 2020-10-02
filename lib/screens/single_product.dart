

import 'package:flutter/material.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:generalshop1/screens/login.dart';
import 'package:generalshop1/screens/utilities/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleProduct extends StatefulWidget {
  final Product product ;


  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_title),
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: ()async{
            SharedPreferences pref = await SharedPreferences.getInstance();
            int userId = pref.getInt('user_id');
            if(userId==null){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

            }else{
              print(userId);
            }
        },

      ),
    );
  }


  Widget _drawScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: _drawImageGallery(context),
              ),
              _drawTitle(context),
              _drawDetails(context),


            ],
          ),
        ),
        _drawLine(),
      ],
    );
  }

  Widget _drawImageGallery(BuildContext context) {
    return PageView.builder(
      itemCount: widget.product.images.length,
      itemBuilder: (context, int position) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Image(
            image: NetworkImage(
              widget.product.images[position],
            ),
          ),
        );
      },
    );
  }
  Widget _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.product_title,
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(widget.product.productCategory.category_name,
                    style: Theme.of(context).textTheme.display1),
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('\$ ${widget.product.product_price.toString()}',
                    style: Theme.of(context).textTheme.headline),
                SizedBox(
                  height: 16,
                ),
                (widget.product.product_discount > 0)
                    ? Text(_calculateDiscount(),
                    style: Theme.of(context).textTheme.display1)
                    : Container(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  String _calculateDiscount() {
    double discount = widget.product.product_discount;
    double price = widget.product.product_price;
    return (price * discount).toString();
  }
  Widget _drawDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        widget.product.product_description,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
  _drawLine() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0,-6),
        child: Container(
          margin: EdgeInsets.only(right: 20,left: 26),
          padding: EdgeInsets.only(left: 20),
          height: 2,
          color: ScreenUtilities.LightGrey,
        ),
      ),
    );
  }




}
