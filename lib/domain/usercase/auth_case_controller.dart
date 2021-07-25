

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_list/domain/repository/auth_repository.dart';
import 'package:flutter_product_list/domain/request/login_request.dart';
import 'package:flutter_product_list/domain/model/user_model.dart' as localUser;
import 'package:flutter_product_list/domain/validator/validator.dart';



enum AuthStatus{
  Uninitialized,
  Authenticated,
  Authenticating,
  UnAunthenticated
}

enum SignUpStatus{
  Uninitialized,
  Registering,
  Registered,
  UnRegistered
}


class AuthCaseController extends ChangeNotifier with Validator {

  final AuthRespositoryInterface authRespositoryInterface;

  String _email;
  String _password;
  AuthStatus _authStatus = AuthStatus.Uninitialized;
  SignUpStatus _signUpStatus = SignUpStatus.Uninitialized;

  UserCredential _usercredential; 

  AuthCaseController({this.authRespositoryInterface});

  

  String get typedEmail => this._email;
  String get typedPassword => this._password;
  AuthStatus get authStatus => this._authStatus;
  SignUpStatus get signUpStatus => this._signUpStatus;
  UserCredential get userCredential => this._usercredential;

    /* En el apartado de los sets lo que se hace es asignarle lo que viene del metodo a la propiedad y posteriormente notificar*/
   set typedEmail(String email) {
     this._email = email;
     notifyListeners();
   }

   set typedPassword(String password) {
     this._password = password;
     notifyListeners();
   }

   void clearFields(){
     this._email = '';
     this._password = '';
     notifyListeners();
   }

    // Cuando se hace uso del metodo se inicia sesion y se cambia el status para interactuar con la vista

   Future<void> handleSignIn() async{
     try {
       _authStatus = AuthStatus.Authenticating;
       notifyListeners();
       final UserCredential credential = await this.authRespositoryInterface.signInWithCredentials(
         new LoginRequest(email: this._email,password: this._password)
       );

       _usercredential = credential;

       _authStatus = AuthStatus.Authenticated;
       notifyListeners();

     } catch (e) {

       _authStatus = AuthStatus.UnAunthenticated;
       notifyListeners();

     }
     
   }
    // Cuando se hace uso del metodo se registra y se cambia el status para interactuar con la vista

   Future<void> handleSignUp() async{
     try {
       _signUpStatus = SignUpStatus.Registering;
       notifyListeners();
       final UserCredential credential = await this.authRespositoryInterface.signUpWithCredentials(
          new localUser.User(email: this._email,password: this._password)
       );

       _usercredential = credential;

       _signUpStatus = SignUpStatus.Registered;
       notifyListeners();

     } catch (e) {

       _signUpStatus = SignUpStatus.UnRegistered;
       notifyListeners();

     }
     
   }

  

}