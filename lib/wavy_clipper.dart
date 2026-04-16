import 'package:flutter/material.dart';

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Titik awal lengkungan

    // Lengkungan pertama (cekung ke atas, lebih dalam)
    var firstControlPoint = Offset(size.width / 4, size.height + 40);
    var firstEndPoint = Offset(size.width / 2, size.height - 40);

    // Lengkungan kedua (cembung ke bawah, lebih meliuk)
    var secondControlPoint = Offset(size.width * (3 / 4), size.height - 120);
    var secondEndPoint = Offset(size.width, size.height - 30);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}