import 'package:flutter/material.dart';
import 'package:generalshop1/api/helpers_api.dart';
import 'package:generalshop1/product/product_category.dart';
import 'package:generalshop1/screens/utilities/helpers_widgets.dart';
import 'package:generalshop1/screens/utilities/screen_utilities.dart';
import 'package:generalshop1/screens/utilities/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  HelpersApi helpersApi = HelpersApi();

  ScreenConfig screenConfig;
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
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

                  return _screen(snapshot.data);
                }
              }
              break;
          }
          return Container();
        });
  }

  Widget _screen(List<ProductCategory> categories) {
    tabController = TabController(
      initialIndex: 0,
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
            tabs: _tabs(categories)),
      ),
      body: Container(),
    );
  }
}

List<Tab> _tabs(List<ProductCategory> categories) {

  List<Tab> tabs = [];

  for(ProductCategory category in categories){
    tabs.add(Tab(
      text : category.category_name ,
    ));
  }
  return tabs ;

}
