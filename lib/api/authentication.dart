import 'dart:convert';
import 'dart:io';

import 'package:generalshop1/api/api_util.dart';
import 'package:generalshop1/customer/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';


class Authentication {
  Future<User> register(String first_name, String last_name, String email,
      String password) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    Map<String, String> body = {
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
    };

    http.Response response =
        await http.post(ApiUtl.AUTH_REGISTER, headers: headers, body: body);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data = body['data'];
      return User.fromJson(data);
    }

    return null;
  }

  Future<User> login(String email, String password) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    Map<String, String> body = {
      'email': email,
      'password': password,
    };
    print('readddyyyy');



    http.Response response = await http.post(ApiUtl.AUTH_LOGIN,headers: headers, body: body);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var data = body['data'];
      print(data);

      print(response.statusCode);

      return User.fromJson(data);

    }

    return null;
  }











  }

