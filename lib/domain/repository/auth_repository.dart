

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_product_list/domain/request/login_request.dart';
import 'package:flutter_product_list/domain/model/user_model.dart' as localUser;


abstract class AuthRespositoryInterface{
  Future<UserCredential> signInWithCredentials(LoginRequest login); 
  Future<UserCredential> signUpWithCredentials(localUser.User user);
}