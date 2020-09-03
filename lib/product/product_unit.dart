import 'package:generalshop1/exceptions/exceptions.dart';


class ProductUnit{
  int unit_id ;
  String unit_name , unit_code ;

  ProductUnit(this.unit_id, this.unit_name, this.unit_code);

  ProductUnit.fromJson(Map<String,dynamic> jsonObject){
    assert(jsonObject['unit_id']!=null , 'Unit ID is null');
    assert(jsonObject['unit_name']!=null , 'Unit name is null');
    assert(jsonObject['unit_code']!=null , 'Unit code is null');


    if( jsonObject['unit_id']==null){
      throw PropertyIsRequired('unit ID') ;
    }
    if( jsonObject['unit_name']==null){
      throw PropertyIsRequired('unit name') ;
    }
    if( jsonObject['unit_code']==null){
      throw PropertyIsRequired('unit code') ;
    }
    this.unit_id = jsonObject['unit_id'];
    this.unit_name = jsonObject['unit_name'];
    this.unit_code = jsonObject['unit_code'];

  }


}