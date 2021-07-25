
import 'package:flutter/material.dart';
import 'package:flutter_product_list/presentation/crud/create_screen.dart';
import 'package:flutter_product_list/presentation/crud/update_screen.dart';
import 'package:flutter_product_list/presentation/productList/productList.dart';
import 'package:flutter_product_list/presentation/signIn/sign_in_screen.dart';
import 'package:flutter_product_list/presentation/signUp/sign_up_screen.dart';

Map<String, WidgetBuilder> appRoutes = {

  SignInScreen.routeName: (BuildContext context)      => new SignInScreen(),
  ProductListScreen.routeName: (BuildContext context) => new ProductListScreen(),
  SignUpScreen.routeName: (BuildContext context)      => new SignUpScreen(),
  CreateScreen.routeName: (BuildContext context)      => new CreateScreen(),
  Updatecreen.routeName: (BuildContext context)       => new Updatecreen(),
  
};