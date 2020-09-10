


import 'package:generalshop1/exceptions/exceptions.dart';

class Country{

  String country_name , capital , currency ;
  int country_id ;

  Country(this.country_name, this.capital, this.currency, this.country_id);

  Country.fromJson(Map<String,dynamic> jsonObject){
    assert(jsonObject['country_id']!=null, 'Country ID is null');
    assert(jsonObject['country_name']!=null, 'Country Name is null');
    assert(jsonObject['currency']!=null, 'Country Currency is null');
    assert(jsonObject['capital']!=null, 'Country Capital is null');

    if(jsonObject['country_id']==null){
      throw PropertyIsRequired('Country ID');
    }
    if(jsonObject['country_name']==null){
      throw PropertyIsRequired('Country Name');
    }
    if(jsonObject['currency']==null){
      throw PropertyIsRequired('currency');
    }
    if(jsonObject['capital']==null){
      throw PropertyIsRequired('Capital');
    }

    this.country_name = jsonObject['country_name'];
    this.country_id = jsonObject['country_id'];
    this.currency = jsonObject['currency'];
    this.capital = jsonObject['capital'];

  }


}