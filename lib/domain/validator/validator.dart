

import 'package:flutter_product_list/domain/model/product_model.dart';

class Validator {

  /* Validacion del email y la contraseña lo que permite detener la accion de hacer un llamado a FireStore si no se cumplen con las reglas */

  bool emailAndPasswordValidator(String email,String password){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(email) && password.length >= 6){
      return true;
    }else{
      return false;
    }
  }

  /*
    Validacion de los campos de la vista de crear y actualizar lo que permite detener la accion de hacer un llamado a FireStore si no se cumplen con las reglas 
    Para esto solo es necesario pasar el objeto ya que el mismo tiene como metodo dicha validacion
  */

  bool productFieldsValidator(Product product){
    if ( product != null ) {
      return product.fieldsValidator();
    } else {
      return false;
    }
  }

}