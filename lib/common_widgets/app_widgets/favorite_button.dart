import 'dart:io';
import 'dart:math';

import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteButtonWidget extends StatelessWidget{
  const FavoriteButtonWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
          height: SizeConfig().h(40),
          width: SizeConfig().w(40),
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig().w(15),
              vertical: SizeConfig().h(60)),
          child: Image(image: AssetImage("assets/not_favorite.png"),
            width: SizeConfig().w(40),
          )),
    );
  }

}