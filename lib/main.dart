import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generalshop1/api/authentication.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:generalshop1/product/product_category.dart';
import 'package:generalshop1/screens/home_page.dart';
import 'package:generalshop1/screens/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/helpers_api.dart';

import 'api/products_api.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();
  if(isSeen==null||!isSeen){
    homePage=OnBoarding();
  }

  runApp(Generalshop1(homePage));
}

class Generalshop1 extends StatelessWidget {
 final Widget homePage ;


  Generalshop1(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
    );
  }
}

