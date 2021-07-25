


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_product_list/domain/repository/auth_repository.dart';
import 'package:flutter_product_list/domain/request/login_request.dart';
import 'package:flutter_product_list/domain/model/user_model.dart' as localUser;


class AuthFirebaseImpl extends  AuthRespositoryInterface {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  

  @override
  Future<UserCredential> signInWithCredentials(LoginRequest login) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: login.email,
      password: login.password
    );
  }

  @override
  Future<UserCredential> signUpWithCredentials(localUser.User user) async{
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }


}