

import 'package:flutter_product_list/domain/model/product_model.dart';

class Validator {
  bool emailAndPasswordValidator(String email,String password){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(email) && password.length >= 6){
      return true;
    }else{
      return false;
    }
  }

  bool productFieldsValidator(Product product){
    if ( product != null ) {
      return product.fieldsValidator();
    } else {
      return false;
    }
  }

}