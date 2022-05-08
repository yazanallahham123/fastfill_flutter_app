import 'dart:io';
import 'dart:math';

import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../helper/const_styles.dart';
import '../../helper/toast.dart';
import '../../model/station/station.dart';
import '../../model/user/bank_card.dart';
import '../../ui/station/purchase_page.dart';
import '../../utils/misc.dart';
import 'favorite_button.dart';

class BankCardWidget extends StatefulWidget{

  final BankCard bankCard;
  const BankCardWidget({required this.bankCard});

  @override
  State<BankCardWidget> createState() => _BankCardWidgetState();
}

class _BankCardWidgetState extends State<BankCardWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(child:
      Column(children: [
        Padding(child:
          Align(child: Text(widget.bankCard.bankName!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: buttonColor1),), alignment: AlignmentDirectional.topStart,),
          padding: EdgeInsets.all(6),
        ),
        InkWell(child:
        Row(children: [
    Expanded(child: Container(
    decoration: BoxDecoration(
    color: Colors.white, borderRadius: radiusAll10),
    padding: EdgeInsets.all(8),
    child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Text(widget.bankCard.cardNumber!, style: TextStyle(fontSize: 12, color: Colors.black),),
          Icon(Icons.copy, size: 15,),
    ],)))]),
        onTap: () {
          Clipboard.setData(ClipboardData(text: widget.bankCard.cardNumber)).then((value) {
            pushToast(translate("messages.bankCardNumberIsCopied"));
            Navigator.pop(context);
          });
        },
        )
      ],)
        , padding: EdgeInsetsDirectional.fromSTEB(10, 1, 10, 1),);
  }
}