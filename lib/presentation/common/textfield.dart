import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final Function(String value) onChange;
  final Color color;
  final bool obscureText;
  final EdgeInsetsGeometry margin;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController controller;

  Input({
     this.icon,
     @required this.labelText,
     this.onChange,
     this.color,
     this.margin,
     this.obscureText = false,
     this.keyboardType,
     this.maxLines,
     this.controller
  });

  @override
  Widget build(BuildContext context) {
    if ( this.controller != null ) {

      this.controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    }
    return Container(
      margin: this.margin,
      child: new TextField(
        obscureText: this.obscureText,
        keyboardType: this.keyboardType,
        maxLines: this.maxLines,
        textInputAction: TextInputAction.done,
        controller: this.controller,
        style: new TextStyle(
          color: Colors.white
        ),
        onChanged: ( this.onChange != null ) 
        ? (String value) {
          this.onChange(value);
        }
        : ( String value ) {},
        decoration: new InputDecoration(
          alignLabelWithHint: true,
          fillColor: new Color(0xff392f4e),
          filled: true,
          labelText: this.labelText,
          labelStyle: new TextStyle(
            color: Colors.white,
          ),
          isDense: true,
          
           enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: new BorderSide(color: Color.fromRGBO(128, 128, 128, 0.4)),
          ),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: new BorderSide(color: Color.fromRGBO(128, 128, 128, 0.4)),
          ),
          prefixIcon: new Icon(
           this.icon,
           size: 12,
           color: Colors.white,
          ),
        ),
      )
    );
  }
}