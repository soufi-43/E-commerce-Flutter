import 'dart:convert';
import 'dart:io';

import 'package:generalshop1/api/api_util.dart';
import 'package:generalshop1/customer/user.dart';
import 'package:generalshop1/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  Map<String, String> headers = {
    'Accept': 'application/json',
  };

  Future<User> register(String first_name, String last_name, String email,
      String password) async {
    await checkInternet();

    Map<String, String> body = {
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
    };

    http.Response response =
        await http.post(ApiUtl.AUTH_REGISTER, headers: headers, body: body);

    switch (response.statusCode) {
      case 201:
        var body = jsonDecode(response.body);
        var data = body['data'];

        print(response.statusCode);

        return User.fromJson(data);
        break;
      case 422:
        throw UnprocessedEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<User> login(String email, String password) async {
    await checkInternet();
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    Map<String, String> body = {
      'email': email,
      'password': password,
    };
    print('readddyyyy');

    http.Response response =
        await http.post(ApiUtl.AUTH_LOGIN, headers: headers, body: body);

    print(response.statusCode);

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        User user = User.fromJson(data);
        await _saveUser(user.user_id, user.api_token);

        print(response.statusCode);

        return user;
        break;
      case 404:
        throw ResourceNotFound('User');
        break;
      case 401:
        throw LoginFailed();
        break;
      case 422:
        throw UnprocessedEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<void> _saveUser(int userID, String apiToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', userID);
    sharedPreferences.setString('api_token', apiToken);
  }
}
