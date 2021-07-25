import 'package:flutter/material.dart';
import 'package:flutter_product_list/domain/usercase/crud_case_controller.dart';
import 'package:flutter_product_list/presentation/common/modal_bottomSheet.dart';
import 'package:flutter_product_list/presentation/crud/update_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
 
 
class ProductCard extends StatelessWidget {

  final int index;
  final EdgeInsetsGeometry margin;

  ProductCard({@required this.index, this.margin});

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final productList = Provider.of<CrudCaseController>(context);


    return new Dismissible(
      key: new Key(productList.allProducts[this.index].id),
        direction:DismissDirection.startToEnd,
        onDismissed: (direction) {
          print("Moviendose");
          productList.handleDeleteProduct(productList.allProducts[this.index].id);
        },
      background: new Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
      child: new Container(
        height: 100,
        width: size.width,
        margin: this.margin,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(20),
           gradient: new LinearGradient(
                stops: [0.02, 0.02],
                colors: [Colors.red, new Color(0xff392f4e)]
           ),
        ),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Icon(
              Icons.store,
              color: Colors.white,
              size: 40
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  width: 200,
                  //color: Colors.amber,
                  child: new Text(
                    productList.allProducts[this.index].name,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                new Container(
                  width: 200,
                  //color: Colors.red,
                  child: new Text(
                    "Price: \$${productList.allProducts[this.index].price}",
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                
                new Container(
                  width: 200,
                  //color: Colors.blue,
                  child: new Text(
                    "Stock: ${productList.allProducts[this.index].stock}",
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: (){
                    productList.loadData(productList.allProducts[this.index]);
                    Navigator.pushNamed(context, Updatecreen.routeName);
                  },
                  child: new Container(
                    width: 200,
                    alignment: Alignment.centerLeft,
                    child: new Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                  ),
                )
                
              ],
            ),
            new GestureDetector(
              onTap: (){
                if( productList.allProducts[this.index].description != '' ){

                  final Modal modal = new Modal();
                  modal.mainBottomSheet(context, "${productList.allProducts[this.index].description}");

                } else {
                  Fluttertoast.showToast(msg: 'No Description',toastLength: Toast.LENGTH_LONG);
                }
              },
              child: new Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 24
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}