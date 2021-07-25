import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final String h1Text;
  final String h2Text;

  TextScreen({
    this.height = 90,
    this.width,
    this.margin,
    this.h1Text,
    this.h2Text
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: this.height,
        width: this.width,
        margin: this.margin,
        child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          new Text(
            this.h1Text,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),
          ),
          new Text(
            this.h2Text,
            style: new TextStyle(
              color: Colors.grey
            ),
          )
        ],
        ),
    );
  }
}