import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_list/data/datasource/crud_firebase_impl.dart';
import 'package:flutter_product_list/domain/usercase/auth_case_controller.dart';
import 'package:flutter_product_list/domain/usercase/crud_case_controller.dart';
import 'package:flutter_product_list/presentation/routes/routes.dart';
import 'package:flutter_product_list/presentation/signIn/sign_in_screen.dart';
import 'package:provider/provider.dart';

import 'data/datasource/auth_firebase_impl.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if (snapshot.hasError) {
          return new Container();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return  MultiProvider(
            providers: [
              
              ChangeNotifierProvider(create: (_) => new AuthCaseController(authRespositoryInterface: new AuthFirebaseImpl())),
              ChangeNotifierProvider(create: (_) => new CrudCaseController(productRepositoryInterface: new CrudFirebaseImpl()))

            ],
            child:  new MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              initialRoute: SignInScreen.routeName,
              routes: appRoutes,
            ),
            
            
          );
        } else {
          return new Center(
          child: new CircularProgressIndicator(),
        ); 
        }
      }
    );
    
  }
}