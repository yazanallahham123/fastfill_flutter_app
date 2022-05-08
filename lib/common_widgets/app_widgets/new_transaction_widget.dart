import 'package:fastfill/model/station/payment_transaction_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/methods.dart';
import '../../model/notification/notification_body.dart';
import '../../model/payment/payment_result_body.dart';
import '../../ui/station/payment_result_page.dart';
import '../../utils/misc.dart';

class NewTransactionWidget extends StatelessWidget
{
  final PaymentTransactionResult transaction;
  const NewTransactionWidget({Key? key, required this.transaction
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
        child:
    InkWell(child:
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

      Padding(child: SvgPicture.asset("assets/svg/refuel.svg", width: 50, height: 50,), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),),
      Expanded(child: Padding(child:  Column(
        children: [
          Align(child: Text((isArabic()) ? transaction.company!.arabicName! : transaction.company!.englishName! + " - " + transaction.company!.code!, style: TextStyle(fontWeight: FontWeight.bold, color: textColor2),), alignment: AlignmentDirectional.topStart,),
          Align(child: Text(DateFormat('yyyy-MM-dd - hh:mm a').format(DateTime.parse(transaction.date!)), style: TextStyle(color: textColor2),), alignment: AlignmentDirectional.topStart,)
        ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),)),

      Padding(child: Column(children: [
        Text(formatter.format(transaction.amount!-transaction.fastfill!)+' '+translate("labels.sdg"), style: TextStyle(color: Colors.white),),
      ],), padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),)

    ],), onTap: () {
      hideKeyboard(context);
      PaymentResultBody prb = PaymentResultBody(date: DateFormat('yyyy-MM-dd - hh:mm a').format(DateTime.parse(transaction.date!)), stationName: (isArabic()) ? transaction.company!.arabicName! : transaction.company!.englishName!, fuelTypeId: transaction.fuelTypeId!, amount: transaction.amount!, value: transaction.fastfill!, status: transaction.status!, fromList: true);
      Navigator.pushNamed(context, PaymentResultPage.route, arguments: prb);
    },));
  }

}