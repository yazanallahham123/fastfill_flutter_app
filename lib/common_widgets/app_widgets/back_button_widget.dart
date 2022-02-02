import 'dart:io';
import 'dart:math';

import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackButtonWidget extends StatelessWidget{
  const BackButtonWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
          alignment: Alignment.topLeft,
          height: SizeConfig().h(50),
          width: SizeConfig().h(50),
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig().w(12),
              vertical: SizeConfig().h(55)),
          child: (isArabic()) ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: SvgPicture.asset(
                'assets/svg/backarrow.svg',
                width: SizeConfig().w(50),
              )) : SvgPicture.asset(
            'assets/svg/backarrow.svg',
            width: SizeConfig().w(50),
          )),
    );
  }

}