import 'package:flutter/material.dart';
import 'package:generalshop1/api/authentication.dart';
import 'package:generalshop1/customer/user.dart';
import 'package:generalshop1/screens/home_page.dart';
import 'package:generalshop1/screens/utilities/screen_utilities.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  Authentication authentication = Authentication();

  bool _loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Transform.translate(
          offset: Offset(0, -75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: Theme.of(context)
                        .textTheme
                        .display3
                        .copyWith(fontSize: 32),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Login to continue to your account',
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        fontSize: 18, color: ScreenUtilities.darkerGreyText),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: _loginForm(context),
              ),
              Container(
                width: double.infinity,
                height: 65,
                margin: EdgeInsets.only(top: 24, bottom: 24),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  color: ScreenUtilities.mainBlue,
                  child: (_loading)
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ))
                      : Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                  onPressed: (_loading) ? null : _loginUser,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                      offset: Offset(0, 4),
                      child: Text(
                        'Don\'t have an account',
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            fontSize: 18,
                            color: ScreenUtilities.darkerGreyText),
                      )),
                  FlatButton(
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.display3,
                    ),
                    onPressed: () {
                      //TODO : send them to sign up page
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(fontSize: 24),
            ),
            style: TextStyle(fontSize: 24),
            validator: (value) {
              if (value.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 24),
            ),
            style: TextStyle(fontSize: 24),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _loginUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;
      User user = await authentication.login(email, password);
      if (user != null) {
        setState(() {
          _loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          _loading = false;
          print('kjkjhkjhkj');
        });
      }
    }
  }
}
