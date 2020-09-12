import 'package:flutter/material.dart';
import 'package:generalshop1/screens/onboarding/onboarding_model.dart';
import 'package:generalshop1/screens/onboarding/onboarding_screen.dart';
import 'package:generalshop1/screens/utilities/screen_utilities.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController;

  double screenHeight;

  double screenWidth;

  int currentIndex = 0;
  bool lastPage = false ;

  List<OnBoardingModel> screens = [
    OnBoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'Welcome!',
      description:
          "Now were up in the big leagues gettinggour turn at bat.The Brady Bunch that's the way we Brady Bunch ",
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding2.jpg',
      title: 'Add To Cart',
      description:
          "Now were up in the big leagues gettinggour turn at bat.The Brady Bunch that's the way we Brady Bunch ",
    ),
    OnBoardingModel(
      image: 'assets/images/onboarding3.jpg',
      title: 'Enjoy Purchase',
      description:
          "Now were up in the big leagues gettinggour turn at bat.The Brady Bunch that's the way we Brady Bunch ",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _mt = MediaQuery.of(context).size.height * 0.2;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: _mt),
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: PageView.builder(
                controller: _pageController,
                itemCount: screens.length,
                itemBuilder: (BuildContext context, int position) {
                  return SingleOnBoarding(screens[position]);
                },
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                    if(index==(screens.length-1)){
                      lastPage=true ;
                    }else{
                      lastPage=false;
                    }
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -(screenHeight * 0.09)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _drawDots(screens.length),
              ),
            ),
          ),
          (lastPage )? _showButton() : Container(),
        ],
      ),
    );
  }

  List<Widget> _drawDots(int qty) {
    List<Widget> widgets = [];
    for (int i = 0; i < qty; i++) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == currentIndex)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.LightGrey,
          ),
          width: 35,
          height: 6,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 0)
              : EdgeInsets.only(right: 24),
        ),
      );
    }
    return widgets;
  }
  Widget _showButton() {
    return Container(
      child: Transform.translate(
        offset: Offset(0, -(screenHeight * 0.1)),
        child: Container(
          color: Colors.white,
          child: SizedBox(
            width: screenWidth * 0.75,
            height:60,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34)),
              color: ScreenUtilities.mainBlue,
              onPressed: () async {

              },
              child: Text(
                'START',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
