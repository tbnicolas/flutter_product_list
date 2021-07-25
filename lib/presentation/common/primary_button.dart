import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  
  final Function() onTap;
  final double height;
  final EdgeInsetsGeometry margin;
  final String buttonText;
  PrimaryButton({this.onTap, this.height, this.margin,this.buttonText});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: new Container(
        alignment: Alignment.center,
        height: this.height,
        margin: this.margin,
        decoration: new BoxDecoration(
          color: new Color(0xff0ef4e4),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: new Text(
          this.buttonText,
          style: new TextStyle(
            color: new Color(0xff013f4c),
            fontSize: 17,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}