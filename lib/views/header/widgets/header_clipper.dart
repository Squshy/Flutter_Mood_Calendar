import 'package:flutter/material.dart';
// Custom clipper to draw a rectangular + circular design for the header

class HeaderClipper extends CustomClipper<Path> {
  @override 
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;

    
    path.lineTo(0, sh*.75);
    path.lineTo(sw*.38, sh*.75);
    path.quadraticBezierTo(sw*.5, sh*1.18, sw*.62, sh*.75);
    path.lineTo(sw, sh*.75);
    path.lineTo(sw, 0);
    path.close();

    return path;
  }

  @override 
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}