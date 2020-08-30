import 'package:flutter/material.dart';
import 'package:generalshop1/api/authentication.dart';



void main(){
  runApp(Generalshop1());
}

class Generalshop1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


    Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('generlshop'),

      ),
      body:Container(child: Center(
        child: FutureBuilder(
          future: authentication.login('soufi-433@hotmail.fr', '123456789'),
          builder: (context,snapShot){
            return Center();
          },
        ),
      )) ,
    );
  }
}

