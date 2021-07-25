
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class  BottomText extends StatelessWidget {
  
  final String greyText;
  final String tapText;
  final EdgeInsetsGeometry margin;
   final Function() onTap;

  BottomText({
    this.greyText,
    this.tapText,
    this.margin,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: this.margin,
      child: new RichText(
        text: new TextSpan(
          text: this.greyText,
          style: new TextStyle(
            color: new Color(0xff4e485f)
          ),
          children: <TextSpan>[
            new TextSpan(
              text: this.tapText,
              style: new TextStyle(
                color: new Color(0xff0ef4e4),
              ),
              recognizer: TapGestureRecognizer()
              ..onTap = () {
                this.onTap();
              }
            )
          ]
        )
      ),
    );
  }
}