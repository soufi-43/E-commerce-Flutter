import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generalshop1/api/authentication.dart';
import 'package:generalshop1/product/Product.dart';
import 'api/helpers_api.dart';

import 'api/products_api.dart';

void main() {
  runApp(Generalshop1());
}

class Generalshop1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    HelpersApi helpersApi = HelpersApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('generlshop'),
      ),
      body: Container(
          child: Center(
            child: FutureBuilder(
              future: helpersApi.fetchState(1,1),
              builder:
                  (BuildContext context,
                  AsyncSnapshot snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.none:
                    return _error('nothing happened:');
                    break;
                  case ConnectionState.waiting:
                  _loading();
                    break;
                  case ConnectionState.active:
                    return _loading();
                    break;
                  case ConnectionState.done:
                    if (snapShot.hasError) {
                      return _error(snapShot.error.toString());
                    } else {
                      if (!snapShot.hasData) {
                        return _error('no data');
                      } else {
                       return ListView.builder(itemBuilder: (BuildContext context,int position){
                         return _drawCard(snapShot.data[position]);
                       },itemCount: snapShot.data.length,);
                      }
                    }

                    break;
                }
                return Container();
              },
            ),
          )),
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawProduct(Product product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(product.product_title),
            (product.images.length > 0) ?
            Image(image: NetworkImage(product.images[0]),)

           :Container(),
          ],
        ),


      ),
    );
  }

  Widget _drawCard(dynamic item){
    return Card(
      child: Padding(padding:EdgeInsets.all(16),
      child: Text(item.state_name),),

    );

  }
}
