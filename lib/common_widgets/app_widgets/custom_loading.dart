import 'package:fastfill/helper/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget{
  const CustomLoading();
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: buttonColor1));
  }

}