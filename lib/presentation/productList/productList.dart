import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_list/domain/usercase/crud_case_controller.dart';
import 'package:flutter_product_list/presentation/common/top_image.dart';
import 'package:flutter_product_list/presentation/crud/create_screen.dart';
import 'package:flutter_product_list/presentation/productList/product_card.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {

  static final routeName = 'productList';
  
    @override
    Widget build(BuildContext context) {
    final crud = Provider.of<CrudCaseController>(context,listen: false);
    final size = MediaQuery.of(context).size;

    return new Scaffold(
      body:new Stack(
        children: [
           new Container(
              height: size.height,
              color: new Color(0xff201a32),
              child: new StreamBuilder<QuerySnapshot>(
                stream:crud.handleGetProducts(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData ){
                    crud.allProducts = snapshot.data.docs;
                    return new ListView.builder(
                      itemCount: snapshot.data.docs.length + 2 ,
                      itemBuilder: (context, index) {
                        if (index == 0 ) {
                          return new TopImage(
                            path: 'assets/productSVG.svg',
                            //path: 'assets/triangulo.png',
                            /* isSvg: false, */
                            height: 200,
                            margin: EdgeInsets.only(top: 20,bottom: 30),
                          );
                        } else if ( index == 1){
                            crud.allProducts = snapshot.data.docs;
                          return new ProductCard(
                            index: index - 1,
                            margin: EdgeInsets.symmetric(horizontal: 20)
                          );
                        } else if ( index == snapshot.data.docs.length + 1 ) {
                          return new SizedBox(height: 200,);
                        } else {
                          return new ProductCard(
                            index: index - 1,
                            margin: EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20
                            )
                          );
                          
                        }
                      },
                    );
                  } else {
                    return new Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                },
              )
           ),
           new Positioned(
            bottom: 0,
            left: 0,
             child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  new CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  new Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(backgroundColor: new Color(0xff0ef4e4), child: Icon(Icons.add), elevation: 0.1,
                     onPressed: () {
                      Navigator.pushNamed(context, CreateScreen.routeName);
                     }
                    ),
                  ),
                ]
               )
             )
          )
        ],
      )
    );
   
   }

}


class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}