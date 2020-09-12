import 'package:generalshop1/exceptions/exceptions.dart';

class User {

  String first_name;

  String last_name;

  String email;

  String api_token;

  int user_id;

  User(this.first_name, this.last_name, this.email,
      [this.api_token, this.user_id]);


  User.fromJson(Map<String,dynamic> jsonObject) {

    assert(jsonObject['user_id']!=null,'User ID is Null');
    assert(jsonObject['first_name']!=null,'first name  is Null');
    assert(jsonObject['last_name']!=null,'last_name  is Null');
    assert(jsonObject['email']!=null,'email  is Null');
    assert(jsonObject['api_token']!=null,'api_token  is Null');


    if(jsonObject['user_id']==null){
      throw PropertyIsRequired('User ID');

    }
    if(jsonObject['first_name']==null){
      throw PropertyIsRequired('first name');

    }
    if(jsonObject['last_name']==null){
      throw PropertyIsRequired('last name');

    }
    if(jsonObject['email']==null){
      throw PropertyIsRequired('email');

    }
    if(jsonObject['api_token']==null){
      throw PropertyIsRequired('api token');

    }






    this.user_id = jsonObject['user_id'];
    this.last_name = jsonObject['last_name'];
    this.first_name = jsonObject['first_name'];
    this.email=jsonObject['email'];
    this.api_token= jsonObject['api_token'];

    
  }




}