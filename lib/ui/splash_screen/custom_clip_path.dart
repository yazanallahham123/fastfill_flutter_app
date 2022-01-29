
import 'dart:ui';

import 'package:fastfill/helper/size_config.dart';
import 'package:flutter/cupertino.dart';

class CustomTriangleClipper extends CustomClipper<Path> {
const CustomTriangleClipper();
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height-SizeConfig().h(30));
    path.lineTo(size.width/2, size.height-SizeConfig().h(100));
    path.lineTo(size.width, size.height-SizeConfig().h(25));
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
