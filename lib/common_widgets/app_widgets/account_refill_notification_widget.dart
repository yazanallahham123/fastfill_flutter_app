import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/const_styles.dart';
import '../../model/notification/notification_body.dart';

class AccountRefillNotificationWidget extends StatelessWidget
{
  final NotificationBody notification;
  const AccountRefillNotificationWidget({Key? key, required this.notification
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: radiusAll16),

        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child:
        Column(children: [
          Padding(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(translate((notification.typeId == "3") ? "labels.accountRefill" : "labels.failAccountRefill"), style: TextStyle(color: (notification.typeId == "3") ? Colors.black : Colors.red),),
              Text((notification.date != null) ? notification.date! : ""),
              Text((notification.time != null) ? notification.time! : "")
            ],),padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),
          Divider(color: (notification.typeId == "3") ? Colors.black45 : Colors.red, thickness: 0.3,),

          Row(children: [

            Image(image: AssetImage((notification.typeId == "3") ? "assets/success.png" : "assets/fail.png"),
                width: 50, height: 50
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child:
                  Padding(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child:
                      Text(translate("labels.syberPay"), style: TextStyle(color: (notification.typeId == "3") ? Colors.black : Colors.red, fontWeight: FontWeight.bold),),),
                      Text((notification.price!+' '+translate("labels.sdg")), style: TextStyle(color: (notification.typeId == "3") ? Colors.black : Colors.red, fontWeight: FontWeight.bold),),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),
              ],)
          ],)],));
  }

}