import 'package:flutter/material.dart';
//import 'package:flutter_product_list/domain/repository/firebase_repository.dart';
import 'package:flutter_product_list/domain/usercase/auth_case_controller.dart';
import 'package:flutter_product_list/presentation/common/primary_button.dart';
import 'package:flutter_product_list/presentation/common/textfield.dart';
import 'package:flutter_product_list/presentation/productList/productList.dart';
import 'package:flutter_product_list/presentation/signIn/bottom_text.dart';
import 'package:flutter_product_list/presentation/signIn/text_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
 
class SignUpScreen extends StatelessWidget {

  static final routeName = 'signUpScreen';
 

  @override
  Widget build(BuildContext context) {
    
    final auth = Provider.of<AuthCaseController>(context,listen: true);
    final size = MediaQuery.of(context).size;
    return new Scaffold(

      body: new ModalProgressHUD(
        inAsyncCall: (auth.signUpStatus == SignUpStatus.Registered),
        progressIndicator: new CircularProgressIndicator(),
        child: new SingleChildScrollView(
          child: Container(
            height: size.height,
            color: new Color(0xff201a32),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 20,top: 50,bottom: 50),
                    width: size.width,
                    child: new Icon(
                      Icons.arrow_back,
                      color: new Color(0xff6b6579),
                    ),
                  ),
                ),
                new TextScreen(
                  height: 90,
                  width: size.width,
                  h1Text: "Create Account",
                  h2Text: "Please fill the input blow here",
                  margin: EdgeInsets.only(bottom: 0, left: 20, right: 20),
                ),
                
                new Input(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  labelText: 'Email',
                  icon: Icons.email,
                  color: Colors.blueAccent,
                  obscureText:false,
                  onChange: (String email){
                    auth.typedEmail = email;
                  },
                ),
                new Input(
                  margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  labelText: 'Password',
                  icon: Icons.lock,
                  color: Colors.blueAccent,
                  obscureText:true,
                  onChange: (String password){
                    auth.typedPassword = password;
                  },
                ),

                new PrimaryButton(
                  buttonText: 'Sing Up',
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  onTap: () async {
                    
                    await auth.handleSignUp();

                    if ( auth.signUpStatus == SignUpStatus.Registered ) {
                      Navigator.pushNamed(context, ProductListScreen.routeName);
                    }

                  },
                ),

                new BottomText(
                  greyText: 'Already have an account?',
                  tapText: ' Sign in',
                  margin: EdgeInsets.only(top: 65),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      )
      
    );
  }
}