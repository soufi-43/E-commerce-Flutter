import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generalshop1/api/authentication.dart';
import 'package:generalshop1/product/Product.dart';
import 'package:generalshop1/product/product_category.dart';
import 'package:generalshop1/screens/home_page.dart';
import 'package:generalshop1/screens/onboarding/onboarding.dart';
import 'package:generalshop1/screens/utilities/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/helpers_api.dart';

import 'api/products_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();
  if (isSeen == null || !isSeen) {
    homePage = OnBoarding();
  }

  runApp(Generalshop1(homePage));
}

class Generalshop1 extends StatelessWidget {
  final Widget homePage;

  Generalshop1(this.homePage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(

          actionsIconTheme: IconThemeData(color: ScreenUtilities.textColor),
          elevation: 0,
          textTheme: TextTheme(
            title: TextStyle(
              height: 2,
              color: ScreenUtilities.textColor,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: ScreenUtilities.textColor,
          labelStyle: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          labelPadding:
              EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 5),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ScreenUtilities.unselected,
          unselectedLabelStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: "Quicksand",
          ),
        ),
      ),
    );
  }
}
