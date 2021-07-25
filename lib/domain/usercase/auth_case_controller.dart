

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_list/domain/repository/auth_repository.dart';
import 'package:flutter_product_list/domain/request/login_request.dart';
import 'package:flutter_product_list/domain/model/user_model.dart' as localUser;



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


class AuthCaseController extends ChangeNotifier {

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
       //return _authStatus;

     } catch (e) {

       _authStatus = AuthStatus.UnAunthenticated;
       notifyListeners();
       //return _authStatus = AuthStatus.Authenticated;

     }
     
   }

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