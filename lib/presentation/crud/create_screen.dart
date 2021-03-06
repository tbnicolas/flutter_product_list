import 'package:flutter/material.dart';
import 'package:flutter_product_list/domain/usercase/crud_case_controller.dart';
import 'package:flutter_product_list/presentation/common/primary_button.dart';
import 'package:flutter_product_list/presentation/common/textfield.dart';
import 'package:flutter_product_list/presentation/signIn/text_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

 
 
class CreateScreen extends StatelessWidget {
  
  static final routeName = 'createScreen';

  @override
  Widget build(BuildContext context) {
    final crud = Provider.of<CrudCaseController>(context,listen: true);
    final size = MediaQuery.of(context).size;
    return new Scaffold(

      body: new ModalProgressHUD(
        inAsyncCall: ( crud.productStatus == ProductStatus.Loading ),
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
                  h1Text: "Create Product",
                  h2Text: "Please fill the input blow here",
                  margin: EdgeInsets.only(bottom: 0, left: 20, right: 20),
                ),
                
                new Input(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  labelText: 'Name',
                  icon: Icons.inventory,
                  color: Colors.blueAccent,
                  obscureText:false,
                  onChange: (String name){
                    crud.changeName(name);
                  },
                ),
                new Input(
                  margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  labelText: 'Price',
                  icon: Icons.request_quote,
                  color: Colors.blueAccent,
                  obscureText:false,
                  keyboardType: TextInputType.number,
                  onChange: (String price){
                    crud.changePrice(int.parse(price));
                  },
                ),
                 new Input(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  labelText: 'Stock',
                  icon: Icons.format_list_numbered,
                  color: Colors.blueAccent,
                  obscureText:false,
                  keyboardType: TextInputType.number,
                  onChange: (String stock){
                    crud.changeStock(int.parse(stock));

                  },
                ),

                new Input(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  labelText: 'Description',
                  color: Colors.blueAccent,
                  obscureText:false,
                  maxLines: 5,
                  onChange: (String description){
                    crud.changeDescription(description);

                  },
                ),


                new PrimaryButton(
                  buttonText: 'Create',
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  onTap: () async {
                    
                    crud.changeId();

                    if (! crud.productFieldsValidator(crud.product) ) {
                      Fluttertoast.showToast(
                          msg: "All fields are required except description",
                          toastLength: Toast.LENGTH_LONG,
                      );
                      return;
                    }
                    await crud.handleCreateProduct();

                    Navigator.pop(context);
                    

                    if (crud.productStatus == ProductStatus.Error) {
                      Fluttertoast.showToast(
                          msg: "Error has orcurred",
                          toastLength: Toast.LENGTH_LONG,
                      );
                    }

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