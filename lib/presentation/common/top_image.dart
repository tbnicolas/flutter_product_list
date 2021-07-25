import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopImage extends StatelessWidget {
  
  final double height;
  final EdgeInsetsGeometry margin;
  final String path;
  final BoxFit fit;
  final bool isSvg;
  TopImage({
    this.height=200,
    this.margin,
    @required this.path,
    this.isSvg = true,
    this.fit = BoxFit.contain
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.height,
      margin: this.margin,
      child: ( this.isSvg )
      ? SvgPicture.asset(this.path,fit: this.fit,)
      : Image.asset(this.path)
    );
  }
}