import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshop1/api/helpers_api.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:generalshop1/product/home_products.dart';
import 'package:generalshop1/product/product_category.dart';
import 'package:generalshop1/screens/single_product.dart';
import 'package:generalshop1/screens/utilities/helpers_widgets.dart';
import 'package:generalshop1/screens/utilities/screen_utilities.dart';
import 'package:generalshop1/screens/utilities/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HelpersApi helpersApi = HelpersApi();
  HomeProductBloc homeProductBloc = HomeProductBloc();
  List<ProductCategory> productsCategories;

  ScreenConfig screenConfig;
  TabController tabController;
  int currentIndex = 0;
  PageController _pageController;
  int dotsCurrentIndex;

  ValueNotifier<int> dotsIndex = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
    homeProductBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);

    return FutureBuilder(
        future: helpersApi.fetchCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductCategory>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return error("no connection made");
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return error(snapshot.error.toString());
              } else {
                if (!snapshot.hasData) {
                  return error('no data found');
                } else {
                  this.productsCategories = snapshot.data;
                  homeProductBloc.fetchProducts
                      .add(this.productsCategories[0].category_id);
                  return _screen(snapshot.data, context);
                }
              }
              break;
          }
          return Container();
        });
  }

  Widget _screen(List<ProductCategory> categories, BuildContext context) {
    tabController = TabController(
      initialIndex: currentIndex,
      vsync: this,
      length: categories.length,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ),
        ],
        bottom: TabBar(
          indicatorColor: ScreenUtilities.mainBlue,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
          onTap: (int index) {
            homeProductBloc.fetchProducts
                .add(this.productsCategories[index].category_id);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: homeProductBloc.productsStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return error('nothing is working');
                  break;
                case ConnectionState.waiting:
                  return loading();
                  break;

                case ConnectionState.done:
                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return error(snapshot.error.toString());
                  } else {
                    if (!snapshot.hasData) {
                      return error('no data found');
                    } else {
                      return _drawProducts(snapshot.data, context);
                    }
                  }
                  break;
              }
              return Container();
            }),
      ),
    );
  }

//  Widget _drawProducts(List<Product> products, BuildContext context) {
//    List<Product> topProducts = _randomTopProducts(products);
//    return Container(
//      child: Column(
//        children: <Widget>[
//          Flexible(
//            child: SizedBox(
//              height: MediaQuery.of(context).size.height * 0.25,
//              child: PageView.builder(
//                  controller: _pageController,
//                  scrollDirection: Axis.horizontal,
//                  itemCount: topProducts.length,
//                  itemBuilder: (context, position) {
//                    return Card(
//                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                      margin: EdgeInsets.only(left: 4, right: 4),
//                      clipBehavior: Clip.hardEdge,
//                      child: Container(
//                        child: Image(
//                          fit: BoxFit.cover,
//                          image:
//                          NetworkImage(topProducts[position].featuredImage()),
//                        ),
//                      ),
//                    );
//                  }),
//            ),
//          ),
//          Container(
//            child:  _pageViewDots(),
//          ),
//        ],
//      ),
//    );
//  }

  Widget _drawProducts(List<Product> products, BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: topProducts.length,
                onPageChanged: (int index) {
                  dotsIndex.value = index ;
                },
                itemBuilder: (context, position) {
                  return InkWell(
                    onTap: () {
                      _gotoSingleProduct(topProducts[position], context);

                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        child: Image(
                          loadingBuilder: (context, image,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return image;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              topProducts[position].featuredImage()),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          ValueListenableBuilder(
            valueListenable: dotsIndex,
            builder: (context,value,_){
              return Container(
                padding: EdgeInsets.only(top: 16,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _drawDots(topProducts.length,value),
                ),
              );
            },
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(right: 8, left: 8, top: 24),
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, position) {
                    return InkWell(
                      onTap: () {
                        _gotoSingleProduct(topProducts[position], context);
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 130,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle),
                              child: Image(
                                loadingBuilder: (context, image,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) {
                                    return image;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                image: NetworkImage(
                                  products[position].featuredImage(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              products[position].product_title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              '\$ ${products[position].product_price.toString()}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _drawDots(int qty, int index) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == index)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.LightGrey,
          ),
          width: 10,
          height: 10,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 10),
        ),
      );
    }
    return widgets;
  }

  List<Product> _randomTopProducts(List<Product> products) {
    Random random = Random();
    List<int> indexes = [];
    int counter = 5;
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
        counter--;
      }
    } while (counter != 0);
    for (int index in indexes) {
      newProducts.add(products[index]);
    }
    return newProducts;
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];

    for (ProductCategory category in categories) {
      tabs.add(Tab(
        text: category.category_name,
      ));
    }
    return tabs;
  }
}

void _gotoSingleProduct(Product product,BuildContext context){
  Navigator.push(context, MaterialPageRoute(
    builder: (context){

      return SingleProduct(product) ;
    }
  ));

}
