import 'package:flutter/material.dart';
//import 'package:flutter_product_list/domain/repository/firebase_repository.dart';
import 'package:flutter_product_list/domain/usercase/auth_case_controller.dart';
import 'package:flutter_product_list/presentation/common/primary_button.dart';
import 'package:flutter_product_list/presentation/common/textfield.dart';
import 'package:flutter_product_list/presentation/productList/productList.dart';
import 'package:flutter_product_list/presentation/signIn/bottom_text.dart';
import 'package:flutter_product_list/presentation/signIn/text_screen.dart';
import 'package:flutter_product_list/presentation/common/top_image.dart';
import 'package:flutter_product_list/presentation/signUp/sign_up_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
 
class SignInScreen extends StatelessWidget {

  static final routeName = 'signInScreen';
  /* SignInScreen._(); */

 /*  static Widget init(BuildContext context){
    return ChangeNotifierProvider(
      create: (_) => AuthCaseController(
        firebaseRespositoryInterface: context.read<FirebaseRespositoryInterface>()
      ),
      builder: (_,___) => new SignInScreen._(),
    );
  } */

  @override
  Widget build(BuildContext context) {
    
    final auth = Provider.of<AuthCaseController>(context,listen: true);
    final size = MediaQuery.of(context).size;
    return new Scaffold(

      body: new ModalProgressHUD(
        inAsyncCall: (auth.authStatus == AuthStatus.Authenticating),
        progressIndicator: new CircularProgressIndicator(),
        child: new SingleChildScrollView(
          child: Container(
            height: size.height,
            color: new Color(0xff201a32),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                new TopImage(
                  path: 'assets/loginSVG.svg',
                  margin: EdgeInsets.only(bottom: 60),
                ),
                new TextScreen(
                  height: 90,
                  width: size.width,
                  h1Text: "LOGIN",
                  h2Text: "Please sign in to continue",
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
                  buttonText: 'Login',
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  onTap: () async {
                    if (!auth.emailAndPasswordValidator(auth.typedEmail, auth.typedPassword)){
                      Fluttertoast.showToast(
                        msg: 'Email example: ex@example.com',
                        toastLength: Toast.LENGTH_LONG
                      );
                      Fluttertoast.showToast(
                        msg: 'Password must be greater than 5 characters',
                        toastLength: Toast.LENGTH_LONG
                      );
                     return; 
                    }
                    await auth.handleSignIn();
                    
                    if ( auth.authStatus == AuthStatus.Authenticated ) {
                      Navigator.pushNamed(context, ProductListScreen.routeName);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Something went wrong',
                        toastLength: Toast.LENGTH_LONG
                      );
                    }

                  },
                ),

                new BottomText(
                  greyText: 'Don\'t have an account?',
                  tapText: ' Sign up',
                  margin: EdgeInsets.only(top: 65),
                  onTap: (){
                    auth.clearFields();
                    Navigator.pushNamed(context, SignUpScreen.routeName);
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